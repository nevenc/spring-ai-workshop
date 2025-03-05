---
title: Running the lab
---

#### Sample Application

To discover the capabilities of **Spring AI**, we will use a sample
[Spring AI Intro](https://github.com/natarajmb/spring-ai-intro) repository.

The **spring-ai-intro** is a Spring Boot application that connects to an LLM.
We will use **OpenAI** in this lab.

{{< note >}}
The lab can be used with Ollama hosted model, but it will be slow as you will be sharing the model with everyone in the lab. If you do decide to use Ollama you have to configure the lab in the **application.yaml** correspondingly.
{{< /note >}}

#### Test OpenAI access

Lets configure the OpenAI key to help with the lab. Its a long string aplogies you would have type it in as their is no better way to share it. 

export OPENAI_API_KEY=`<check-with-insturctor>`

```execute
curl https://api.openai.com/v1/chat/completions \
-H "Content-Type: application/json" \
-H "Authorization: Bearer $OPENAI_API_KEY" \
-d '{
        "model": "gpt-4o",
        "store": true,
        "messages": [
            {"role": "user", "content": "who are you"}
        ]
    }' | jq
```

You should see a JSON response from a **OpenAI** similar to below

```json
{
  "id": "chatcmpl-B7r1mNuNyW40BHhVsJNwpDqkNBp9s",
  "object": "chat.completion",
  "created": 1741211834,
  "model": "gpt-4o-2024-08-06",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "I’m an AI developed by OpenAI here to help answer your questions and provide information. How can I assist you today?",
        "refusal": null
      },
      "logprobs": null,
      "finish_reason": "stop"
    }
  ],
  "usage": {
    ...
    },
    "completion_tokens_details": {
      ...
    }
  },
  ...
}
```


#### Trying out the Ollama Model (alternative)

Let's validate that the Ollama model works in this environment by running the following request.
```execute
curl -s -X POST http://llama-proxy.{{< param workshop_namespace >}}:11434/api/generate \
     -H "Content-Type: application/json" \
     -d '{
           "model": "llama3.2",
           "prompt": "Who are you?",
           "stream": false
         }' | jq 'del(.context)'
```

{{< warning >}}
The response might be a bit slow since we are hosting the LLMs on a CPU-based system without GPUs.
{{< /warning >}}

You should see a JSON response from a **llama3.2** model hosted on a local Ollama server:

```json
{
  "model": "llama3.2",
  "created_at": "2025-02-01T10:00:00.263710817Z",
  "response": "I'm an artificial intelligence model known as Llama. Llama stands for \"Large Language Model Meta AI.\"",
  "done": true,
  "done_reason": "stop",
  "total_duration": 21750302650,
  "load_duration": 4158088904,
  "prompt_eval_count": 29,
  "prompt_eval_duration": 4185000000,
  "eval_count": 23,
  "eval_duration": 13403000000
}
```

#### Configure Application

We need to configure the application details in `application.yaml`.

```editor:open-file
file: ~/spring-ai-intro/src/main/resources/application.yaml
description: Open application.yaml configuration file
line: 3
```

Notice that we will be using `openai` configuration.
```editor:select-matching-text
file: ~/spring-ai-intro/src/main/resources/application.yaml
description: Highlight model provider
text: "provider: openai"
```

Notice the default OpenAI base url.
```editor:select-matching-text
file: ~/spring-ai-intro/src/main/resources/application.yaml
description: Highlight the URL for OpenAI model.
text: "https://api.openai.com/"
start: 21
stop: 42
```

Notice we are reading the OpenAI API key from environment variable.
```editor:select-matching-text
file: ~/spring-ai-intro/src/main/resources/application.yaml
description: Highlight the OpenAI API key.
text: "${OPENAI_API_KEY}"
start: 22
stop: 35
```

#### Ollam configuration (Optional)

**Optional** Notice the default Ollama base url.
```editor:select-matching-text
file: ~/spring-ai-intro/src/main/resources/application.yaml
description: Highlight the host URL for Ollama model 
text: "localhost"
start: 12
stop: 14
```

**Optional** We need to substitute that with a working Ollama endpoint.
```editor:replace-text-selection
file: ~/spring-ai-intro/src/main/resources/application.yaml
description: Replace with environment-specific Ollama host URL
text: "llama-proxy.{{< param workshop_namespace >}}"
```

**Optional** Notice that we are using `llama3.2` model in Ollama.
```editor:select-matching-text
file: ~/spring-ai-intro/src/main/resources/application.yaml
description: Highlight used model
text: "llama3.2"
start: 15
stop: 17
```

#### Running the Application

Let's start the application in the second terminal.
```terminal:execute
command: cd spring-ai-intro
session: 2
```

```terminal:execute
command: ./mvnw spring-boot:run
session: 2
```

#### Execute a Simple Chat Query

After the application has started successfully, we can run a simple chat query. 

Please go ahead and execute the following command in the terminal to invoke a call to the LLM.
```execute
http -b localhost:8080/chat/simple
```

Observe the output.
```
I'm an AI language model created by OpenAI, designed to assist with information and answer questions to the best of my ability. How can I help you today?
```

**Congratulations!** You have successfully called an LLM model from your Spring Boot application.

#### Stop the Application

You can stop the application in the second terminal.
```terminal:interrupt
session: 2
```
