---
title: Introduction to Spring AI
---

** Spring AI [(Docs)](https://docs.spring.io/spring-ai/reference/)


```execute
curl -X POST http://llama.{{< param session_namespace >}}:11434/api/generate \
     -H "Content-Type: application/json" \
     -d '{
           "model": "llama3.1",
           "prompt": "Tell me in as few words as possible what AI is.",
           "stream": false
         }'
```