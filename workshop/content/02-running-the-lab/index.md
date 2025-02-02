---
title: Running the lab
---

#### Sample Application

To discover the capabilities of **Spring AI**, we will use a sample
[Spring AI Intro](https://github.com/nevenc/spring-ai-intro) repository.

The **Spring AI Intro** is a Spring Boot application that connects to LLM.
In this lab we will use an **Ollama** hosted models locally:

The lab can be used with OpenAI LLMs, but you need to get an OPENAI_API_KEY
and configure the lab in **application.yaml** correspondingly.

#### Test Ollama Model

Let's test that the Ollama model works in this environment, e.g.

```execute
curl -s -X POST http://llama.{{< param session_namespace >}}:11434/api/generate \
     -H "Content-Type: application/json" \
     -d '{
           "model": "llama3.2",
           "prompt": "Who are you?",
           "stream": false
         }' | jq .
```

Since we are hosting the LLMs on CPU-based system, with no GPUs - the response might
be a bit slow.

You should see a JSON response from an **llama3.2** model hosted on local Ollama server:

```json
{
  "model": "llama3.2",
  "created_at": "2025-02-01T10:00:00.263710817Z",
  "response": "I'm an artificial intelligence model known as Llama. Llama stands for \"Large Language Model Meta AI.\"",
  "done": true,
  "done_reason": "stop",
  "context": [
    128006,
    9125,
    128007,
    271,
    38766,
    1303,
    33025,
    2696,
    25,
    6790,
    220,
    2366,
    18,
    271,
    128009,
    128006,
    882,
    128007,
    271,
    15546,
    527,
    499,
    30,
    128009,
    128006,
    78191,
    128007,
    271,
    40,
    2846,
    459,
    21075,
    11478,
    1646,
    3967,
    439,
    445,
    81101,
    13,
    445,
    81101,
    13656,
    369,
    330,
    35353,
    11688,
    5008,
    16197,
    15592,
    1210
  ],
  "total_duration": 21750302650,
  "load_duration": 4158088904,
  "prompt_eval_count": 29,
  "prompt_eval_duration": 4185000000,
  "eval_count": 23,
  "eval_duration": 13403000000
}
```

#### Configure Application

We need to configure the application details in `application.yaml`, e.g.

```editor:open-file
file: ~/spring-ai-intro/src/main/resources/application.yaml
description: Open application.yaml configuration file
line: 3
```

Notice that we will be using `ollama` configuration, e.g.

```editor:select-matching-text
file: ~/spring-ai-intro/src/main/resources/application.yaml
description: Find line where we define model to use
text: "provider: ollama"
```

Notice the default Ollama base-url, e.g. 

```editor:select-matching-text
file: ~/spring-ai-intro/src/main/resources/application.yaml
description: Find the base-url host for ollama model 
text: "localhost"
start: 12
stop: 14
```

We need to substitute that with a working Ollama endpoint, e.g.

```editor:replace-text-selection
file: ~/spring-ai-intro/src/main/resources/application.yaml
description: replace with Ollama host base-url
text: "llama.{{< param session_namespace >}}"
```

Notice that we are using `llama3.2` model in Ollama, e.g.

```editor:select-matching-text
file: ~/spring-ai-intro/src/main/resources/application.yaml
description: observe the Ollama model we will use
text: "llama3.2"
start: 15
stop: 17
```

#### Run the application

We can start the application in the second terminal:

```terminal:execute
command: cd spring-ai-intro
session: 2
```

```terminal:execute
command: ./mvnw clean package spring-boot:run
session: 2
```

#### Run a simple chat query

Let's run a simple chat query. Execute the following command in terminal to invoke call to LLM, e.g.

```execute
http localhost:8080/chat/simple
```

Observe the output, e.g.

```text
HTTP/1.1 200 
Connection: keep-alive
Content-Length: 101
Content-Type: text/plain;charset=UTF-8
Date: Sat, 01 Feb 2025 10:10:43 GMT
Keep-Alive: timeout=60

I'm an artificial intelligence model known as Llama. Llama stands for "Large Language Model Meta AI."
```

**Congratulations!** You have successfully called LLM model from your Spring Boot app.

#### Stop the application

You can stop the application in the second terminal:

```terminal:interrupt
session: 2
```
