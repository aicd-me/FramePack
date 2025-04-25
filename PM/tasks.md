# Task Tracking

## Task Tracking Format
✅ = Completed task
⏳ = In progress / Pending verification
❌ = Failed or blocked task
No symbol = Not started

always update the depency files if you add new libraries

## Tasks

✅ Add a Dockerfile to the project.
✅ Add a docker-compose.yaml file to the project.
✅ Add a healthcheck to the docker-compose.yaml file.
✅ Remove GPU-specific configuration from docker-compose.yaml for macOS compatibility.
✅ Re-add GPU-specific configuration to docker-compose.yaml for Nvidia machines.
✅ Add missing OpenGL libraries to Dockerfile.
✅ Add additional potentially missing libraries for OpenCV to Dockerfile.
✅ Add libglib2.0-0 to Dockerfile to resolve libgthread-2.0.so.0 error.
✅ Correct CMD instruction in Dockerfile to use shell form for environment variable.
✅ Move application start command from Dockerfile to docker-compose.yaml.
✅ Remove unrecognized --listen argument from docker-compose.yaml command.
✅ Add --share flag to the command in docker-compose.yaml.