# Design decisions

The tools inspect resources and report findings; they do not remediate automatically. The systemd timer adds scheduling jitter and service sandboxing. A synthetic df fixture tests disk alerts without consuming real storage. Container observations must be interpreted separately from host or cgroup limits.

See README.md for operation and VALIDATION.md for the checks actually performed.
