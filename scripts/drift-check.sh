#!/bin/bash
set -e

terraform init -input=false

terraform plan -detailed-exitcode
EXIT_CODE=$?

if [ "$EXIT_CODE" -eq 2 ]; then
  echo "❌ Infrastructure drift detected"
  exit 1
elif [ "$EXIT_CODE" -eq 0 ]; then
  echo "✅ No drift detected"
else
  echo "⚠️ Terraform error"
  exit 1
fi
