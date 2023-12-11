{
    "name": "tool name",
    "description": "tool description",
    "tool-version": "v0.1.0",
    "schema-version": "0.5",
    "command-line": "echo [PARAM1] [PARAM2] [FLAG1] > [OUTPUT1]",
    "container-image": {
        "image": "user/image",
        "index": "docker://",
        "type": "singularity"
    },
    "inputs": [
        {
            "id": "basic_param1",
            "name": "The first parameter",
            "optional": true,
            "type": "File",
            "value-key": "[PARAM1]"
        },
        {
            "id": "basic_param2",
            "name": "The second parameter",
            "optional": false,
            "type": "String",
            "value-choices": [
                "mychoice1.log",
                "mychoice2.log"
            ],
            "value-key": "[PARAM2]"
        },
        {
            "command-line-flag": "-f",
            "id": "basic_flag1",
            "name": "The first flag",
            "optional": true,
            "type": "Flag",
            "value-key": "[FLAG1]"
        }
    ],
    "output-files": [
        {
            "id": "basic_output1",
            "name": "The first output",
            "optional": false,
            "path-template": "[PARAM2].txt",
            "path-template-stripped-extensions": [
                ".log"
            ],
            "value-key": "[OUTPUT1]"
        }
    ],
    "groups": [
        {
            "all-or-none": true,
            "id": "group1",
            "members": [
                "basic_param1",
                "basic_flag1"
            ],
            "mutually-exclusive": false,
            "name": "the param group",
            "one-is-required": false
        }
    ],
    "tags": {
        "foo": "bar",
        "purpose": "testing",
        "status": "example"
    },
    "suggested-resources": {
        "cpu-cores": 1,
        "ram": 1,
        "walltime-estimate": 60
    },
    "error-codes": [
        {
            "code": 1,
            "description": "Crashed"
        }
    ]
}