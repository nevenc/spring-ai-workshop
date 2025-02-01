---
title: First Spring AI Application
---

#### Spring AI Starters

Spring AI leverages Spring Boot starters to configure important libraries
for connecting to various LLM models. 

Explore the `spring-ai-ollama-spring-boot-starter` in pom.xml, e.g.

```editor:open-file
file: ~/spring-ai-intro/pom.xml
description: Open pom.xml configuration file
line: 44
```

```xml
	<dependency>
		<groupId>org.springframework.ai</groupId>
		<artifactId>spring-ai-ollama-spring-boot-starter</artifactId>
	</dependency>
```

There are other starters you could use, check the
[list of supported chat models](https://docs.spring.io/spring-ai/reference/api/chat/comparison.html).

We have also configured the lab for possible connection to OpenAI, e.g.

```XML
	<dependency>
		<groupId>org.springframework.ai</groupId>
		<artifactId>spring-ai-openai-spring-boot-starter</artifactId>
	</dependency>
```

#### Spring AI Configuration

Spring AI can be configured through Spring properties in `application.yaml` file.

```editor:open-file
file: ~/spring-ai-intro/src/main/resources/application.yaml
description: Open application.yaml configuration file
line: 12
```

```YAML
spring:
  application:
    name: spring-ai-intro
  ai:
    ollama:
        base-url: http://llama.{{< param session_namespace >}}:11434/
        chat:
          options:
            model: llama3.2
        embedding:
          options:
            model: nomic-embed-text
```

Notice, we configured the Ollama Chat model `llama3.2` and embedding model `nomic-embed-text`.

#### ChatClient API

The **ChatClient** offers a fluent API for communicating with an AI Model.
It supports both synchronous and streaming programming model.

The **ChatClient** is created using **ChatClient.Builder** object.

```editor:open-file
file: ~/spring-ai-intro/src/main/java/dev/tanzu/demo/chat/SimpleChatController.java
description: Open SimpleChatController file
line: 21
```

```Java
@RestController
class SimpleChatController {

    private final ChatClient chatClient;

    SimpleChatController(ChatClient.Builder builder) {
        this.chatClient = builder.build();
    }

    @GetMapping(value = "/chat/simple")
    String chat(@RequestParam(value = "query", defaultValue = "who are you") String query) {

        // Simple ChatClient API call to your LLM model
        return chatClient.prompt().user(query).call().content();

    }

}
```

Notice how easy is to create ChatClients and send messages to your AI Models.

You can read more on [ChatClient API Documentation](https://docs.spring.io/spring-ai/reference/api/chatclient.html).

#### Run the application

Let's run the application again, e.g.

```terminal:execute
command: ./mvnw spring-boot:run
session: 2
```

#### Execute simple queries

Let's run few queries, e.g.

```execute
http localhost:8080/chat/simple?query="What is the city of Stockholm known for? Give me top three things." 
```

```text
Stockholm, the capital city of Sweden, is known for many things. Here are three of its most notable claims to fame:

1. **Architectural Marvels**: Stockholm is home to a plethora of stunning architectural styles and structures, including the iconic Old Town (Gamla Stan), the Vasa Museum, which houses the world's only preserved 17th-century ship, and the beautiful Royal Palace, with its grand halls and impressive art collection.

2. **Natural Beauty**: The city is situated on the shores of Lake Mälaren and the Baltic Sea, offering breathtaking views and access to numerous parks, gardens, and outdoor recreational areas. It's also close to the stunning Drottningholm Palace, a UNESCO World Heritage Site, and the picturesque archipelago.

3. **Rich History and Culture**: Stockholm has a rich cultural heritage, with influences from its Viking past, its role as a major trading hub during the Hanseatic League era, and its position as the capital of Sweden. The city is home to numerous museums, galleries, and performance venues, including the legendary Royal Dramatic Theatre.

These are just a few examples of what makes Stockholm such a unique and captivating city!
```

```execute
http localhost:8080/chat/simple?query="You are a comedian. Can you write a short poem about Stockholm?"
```

```text
Here's a quick attempt:

In Stockholm, the nights are long
But the party never goes wrong
The ABBA revival's in full swing
And the Meatballs sing their funky thing

I wander down the cobblestone street
Where IKEA dreams and hipsters meet
The harbor's where the boats all play
While the hipsters sip coffee all day

In Stockholm, I've lost my phone
But found a new friend by the Stockholm Stone
It's a weird town, but it feels like home
Where the crazy parties never go unknown
```

```execute
http localhost:8080/chat/simple?query="You are a haiku writer. Can you write a short haiku about Stockholm? In Swedish?" 
```

```text
Here is a haiku about Stockholm in Swedish:

Stockholms skarvar
Guldtimmare i mörkret
Nådens stads ljus

Translation:
The Stockholm arches
Golden trumpets in the dark
City's gentle light
```

Feel free to play with various queries. 

Note that responses might take a bit longer since we are running
this model on a local CPU Ollama host.

#### Stop the application

You can stop the application in the second terminal:

```terminal:interrupt
session: 2
```