test:
	bash tests/checks.sh
	shellcheck inventory.sh disk-check.sh uptime-report.sh checks/resource-report.sh tests/checks.sh
