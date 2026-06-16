import json, os, sys

template_path = sys.argv[1]
output_path   = sys.argv[2]
api_id        = os.environ.get('TELEGRAM_API_ID', '')
api_hash      = os.environ.get('TELEGRAM_API_HASH', '')

with open(template_path) as f:
    config = json.load(f)

def patch(obj):
    if isinstance(obj, dict):
        for k in list(obj.keys()):
            if k in ('apiId', 'api_id'):
                obj[k] = api_id
            elif k in ('apiHash', 'api_hash'):
                obj[k] = api_hash
            else:
                patch(obj[k])
    elif isinstance(obj, list):
        for item in obj:
            patch(item)

patch(config)

with open(output_path, 'w') as f:
    json.dump(config, f, indent=2)

print('Config written to', output_path)
print(json.dumps(config, indent=2))
