#!/bin/bash
set -e
echo "🔗 Installing ngrok..."

# Install ngrok via npm
npm install -g ngrok

# Authenticate ngrok
ngrok authtoken "${NGROK_AUTH_TOKEN}" || true

# Start ngrok in background
ngrok http 80 --log=stdout > ngrok.log &
NGROK_PID=$!

# Wait for tunnel to open
sleep 6

# Fetch the public URL
NGROK_URL=$(curl -s http://127.0.0.1:4040/api/tunnels | jq -r .tunnels[0].public_url)
echo "🎯 Site available at: $NGROK_URL"

# Export for other GitHub steps
echo "NGROK_URL=$NGROK_URL" >> $GITHUB_ENV

# Optional: sleep to keep the tunnel alive for 5 mins
echo "🕒 Keeping ngrok tunnel alive for 5 minutes..."
sleep 300

# Kill ngrok afterwards (optional)
kill $NGROK_PID || true
