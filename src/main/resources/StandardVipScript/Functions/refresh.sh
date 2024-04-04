SHANOIR_TOKEN_LOCATION="${PWD}/cache/SHANOIR_TOKEN.txt"
SHANOIR_REFRESH_TOKEN_LOCATION="${PWD}/cache/SHANOIR_REFRESH_TOKEN.txt"
REFRESHING_JOB_STARTED=false
REFRESH_PID=""

#
# This is a background process to refresh shanoir token
# URIs are of the form of the following example. A single "/", instead
# of 3, after "shanoir:" is also allowed.
# shanoir:/path/to/file/filename?&refreshToken=eyJhbGciOiJIUzI1NiIsInR5cCIgOiAiSldUIiwia2lk....&keycloak_client_id=....&keycloak_client_secret=...
# The mandatory arguments are: keycloak_client_id, keycloak_client_secret.
#
function refresh_token {
    touch "$SHANOIR_TOKEN_LOCATION"
    touch "$SHANOIR_REFRESH_TOKEN_LOCATION"

    local subshell_refresh_token=$(cat "$SHANOIR_REFRESH_TOKEN_LOCATION")

    echo "refresh token process started !"

    local URI=$1
    local keycloak_client_id=$(echo "$URI" | sed -r 's/^.*[?&]keycloak_client_id=([^&]*)(&.*)?$/\1/i')
    local refresh_token_url=$(echo "$URI" | sed -r 's/^.*[?&]refresh_token_url=([^&]*)(&.*)?$/\1/i')

    if [[ ! "$subshell_refresh_token" ]]; then
        # initializing the refresh token
        subshell_refresh_token=$(echo "$URI" | sed -r 's/^.*[?&]refreshToken=([^&]*)(&.*)?$/\1/i')
        echo "$subshell_refresh_token" > "$SHANOIR_REFRESH_TOKEN_LOCATION"
    fi

    while :; do

        # get the new refresh token
        subshell_refresh_token=$(cat "$SHANOIR_REFRESH_TOKEN_LOCATION")

        # the response format is "{"status":"status"}"
        # this response format is made to handle error while getting the refreshed token in the same time
        COMMAND() {
            curl -w "{\"status\":\"%{http_code}\"}" -sb -o --request POST "${refresh_token_url}" --header "Content-Type: application/x-www-form-urlencoded" --data-urlencode "client_id=${keycloak_client_id}" --data-urlencode "grant_type=refresh_token" --data-urlencode "refresh_token=${subshell_refresh_token}"
        }

        refresh_response=$(COMMAND)
        status_code=$(echo "$refresh_response" | grep -o '"status":"[^"]*' | grep -o '[^"]*$')

        if [[ "$status_code" -ne 200 ]]; then
            error_message=$(echo "$refresh_response" | grep -o '"error_description":"[^"]*' | grep -o '[^"]*$')
            error "error while refreshing the token with status : ${status_code} and message error : ${error_message}"
            exit 1
        fi

        # setting the new tokens
        echo "$refresh_response" | grep -o '"access_token":"[^"]*' | grep -o '[^"]*$' > "$SHANOIR_TOKEN_LOCATION"
        echo "$refresh_response" | grep -o '"refresh_token":"[^"]*' | grep -o '[^"]*$' > "$SHANOIR_REFRESH_TOKEN_LOCATION"

        sleep 240
    done

}
#
# Cleanup method: stop the refreshing process
#

function stopRefreshingToken {
    if [ "${REFRESH_PID}" != "" ]; then
        info "Killing background refresh token process with id : ${REFRESH_PID}"
        kill -9 "${REFRESH_PID}"
        REFRESH_PID=""
        echo "refresh token process ended !"
    fi
}
#
# The refresh token may take some time, this method is for that purpose
# and it exit the program if it's timed out
#

function wait_for_token {
    local token=""
    local attempts=0

    while [[ "${attempts}" -ne 3 ]]; do
        token=$(cat "$SHANOIR_TOKEN_LOCATION")
        if [[ "${token}" == "" ]]; then
            echo "token is not refreshed yet, waiting for 3 seconds..."
            echo "attempts : ${attempts}"
            attempts=$((attempts + 1))
            sleep 3
        else
            echo "token is refreshed !"
            break
        fi
    done
}