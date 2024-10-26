path_prefix="/kv"

status_code=$(
  # Read key-value pair
  # https://developers.cloudflare.com/api/operations/workers-kv-namespace-read-key-value-pair
  curl \
    "https://api.cloudflare.com/client/v4/accounts/${ACCOUNT_ID}/storage/kv/namespaces/${NAMESPACE_ID}/values/${KEY_NAME}" \
    -H "Authorization: Bearer ${AUTH}" \
    -H 'Content-Type: application/json' \
    -o "${path_prefix}/${OUTPUT_FILE}" \
    -w "%{http_code}" \
    -s
)

if [ "$status_code" -eq 200 ]; then
  success=$(jq '.success' "${path_prefix}/${OUTPUT_FILE}")
  if [ "$success" = "false" ]; then
    echo "failed with status $status_code, error: $(cat ${path_prefix}/${OUTPUT_FILE})"
    exit 1
  fi
else
  echo "failed with status $status_code, error: $(cat ${path_prefix}/${OUTPUT_FILE})"
  exit 1
fi

echo "status_code: $status_code"
echo "${OUTPUT_FILE}: $(cat ${path_prefix}/${OUTPUT_FILE})"
