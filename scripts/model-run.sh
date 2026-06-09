# Instance 1: 13B reasoning/build model
./llama-server \
  --model models/llama-13b-q4_k_m.gguf \
  --alias local-13b \
  --port 1234 \
  --n-gpu-layers 40 \
  --ctx-size 4096 \
  --parallel 1 &

# Instance 2: 7B planning/explore model
./llama-server \
  --model models/llama-7b-q4_k_m.gguf \
  --alias local-7b \
  --port 1235 \
  --n-gpu-layers 24 \
  --ctx-size 2048 \
  --parallel 1 &
