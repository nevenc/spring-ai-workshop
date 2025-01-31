---
title: Introduction to Spring AI
---

** Spring AI [(Docs)](https://docs.spring.io/spring-ai/reference/)


```execute
curl -X POST https://llama-{{session_hostname}}/api/generate \
     -H "Content-Type: application/json" \
     -d '{
           "model": "llama3.1",
           "prompt": "What is Spring AI?",
           "stream": false
         }'
```