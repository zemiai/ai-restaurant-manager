#!/bin/bash
# MiniMax TTS Helper - Generate speech from text
# Usage: ./minimax_tts.sh "Your text here" [output_file.mp3]

set -e

TEXT="${1:-Hello, welcome to Brickhouse!}"
OUTPUT="${2:-/home/zemi/clawd/media/minimax/announcement.mp3}"

# Load API key
API_KEY_FILE="/home/zemi/clawd/.secrets/minimax_mcp.apikey"

if [[ ! -f "$API_KEY_FILE" ]]; then
    echo "❌ API key not found at $API_KEY_FILE"
    exit 1
fi

API_KEY=$(cat "$API_KEY_FILE")
mkdir -p "$(dirname "$OUTPUT")"

echo "🎤 Generating speech..."
echo "   Text: ${TEXT:0:50}..."
echo "   Output: $OUTPUT"

# Call API
RESPONSE=$(curl -s -X POST "https://api.minimax.io/v1/t2a_v2" \
  -H "Authorization: Bearer $API_KEY" \
  -H "Content-Type: application/json" \
  -d "{
    \"model\": \"speech-02-hd\",
    \"text\": \"$TEXT\",
    \"output_format\": \"url\",
    \"voice_setting\": {
      \"voice_id\": \"English_expressive_narrator\",
      \"speed\": 1.0,
      \"vol\": 1.0
    }
  }")

# Parse URL from response
AUDIO_URL=$(echo "$RESPONSE" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('data',{}).get('audio','') or d.get('data',{}).get('audio_url',''))")

if [[ -z "$AUDIO_URL" || "$AUDIO_URL" == "None" ]]; then
    echo "❌ Failed to generate audio"
    echo "$RESPONSE" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('base_resp',{}).get('status_msg',d))"
    exit 1
fi

# Download audio
curl -s "$AUDIO_URL" --output "$OUTPUT"

if file "$OUTPUT" | grep -q "audio\|MP3"; then
    echo "✅ Audio saved to: $OUTPUT"
    echo "   Size: $(du -h "$OUTPUT" | cut -f1)"
else
    echo "❌ Download failed"
    rm -f "$OUTPUT"
    exit 1
fi
