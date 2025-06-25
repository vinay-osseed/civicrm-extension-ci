#!/bin/bash
set -e
echo "🔗 Installing ngrok..."
npm install -g ngrok
ngrok authtoken "${{ secrets.NGROK_AUTH_TOKEN }}" 2>/dev/null || true
export NGROK_URL=$(ngrok http 80 --log=stdout | tee ngrok.log & sleep 6 && curl -s http://127.0.0.1:4040/api/tunnels | jq -r .tunnels[0].public_url)
echo "🎯 Site available at: $NGROK_URL"
echo "NGROK_URL=$NGROK_URL" >> $GITHUB_ENV
