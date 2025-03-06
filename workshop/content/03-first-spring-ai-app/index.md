---
title: First Spring AI Application
---

#### Spring AI Starters

Spring AI leverages Spring Boot starters to configure important libraries
for connecting to various LLM models. 

Explore the `spring-ai-openai-spring-boot-starter` in pom.xml.

```editor:select-matching-text
file: ~/spring-ai-intro/pom.xml
description: Find line where we define starter
text: "spring-ai-openai-spring-boot-starter"
```

```
<dependency>
	<groupId>org.springframework.ai</groupId>
	<artifactId>spring-ai-openai-spring-boot-starter</artifactId>
</dependency>
```

There are other starters you could use. Check the [list of supported chat models](https://docs.spring.io/spring-ai/reference/api/chat/comparison.html).

We have also configured the lab for possible connection to Ollama.

```editor:select-matching-text
file: ~/spring-ai-intro/pom.xml
description: Find line where we define starter
text: "spring-ai-ollama-spring-boot-starter"
```

```
<dependency>
	<groupId>org.springframework.ai</groupId>
	<artifactId>spring-ai-ollama-spring-boot-starter</artifactId>
</dependency>
```

#### Spring AI Configuration

We have configured eveything we need to connect to OpenAI. If you are using Ollama follow the configuration.

#### Ollam Configuration (Optional)
Spring AI can be configured through Spring properties in `application.yaml` file.

```editor:open-file
file: ~/spring-ai-intro/src/main/resources/application.yaml
description: Open application.yaml configuration file
line: 12
```

```
spring:
  application:
    name: spring-ai-intro
  ai:
    ollama:
        base-url: http://llama-proxy.{{< param workshop_namespace >}}:11434/
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
It supports both a synchronous and streaming programming model.

The **ChatClient** is created using **ChatClient.Builder** object.


```editor:select-matching-text
file: ~/spring-ai-intro/src/main/java/dev/tanzu/demo/chat/SimpleChatController.java
description: Find line in SimpleChatController
text: "builder.build()"
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

Notice how easy it is to create ChatClients and send messages to your AI models.

You can read more on [ChatClient API Documentation](https://docs.spring.io/spring-ai/reference/api/chatclient.html).

#### Run the Application to Execute Simple Queries

Let's rerun the application.

```terminal:execute
command: ./mvnw clean spring-boot:run
session: 2
```

{{< note >}}
Please wait for the Spring application to finish in lower terminal, e.g. **Started AiApplication in ...**
{{< /note >}}

Here are a few sample queries to execute.
```execute
http -b localhost:8080/chat/simple?query="List all states of India with their capital"
```

{{< note >}}
The responses might take a bit longer since we are running this model on a local CPU Ollama host
{{< /note >}}

```
Here is a list of the states of India along with their capitals:

1. Andhra Pradesh - Amaravati
2. Arunachal Pradesh - Itanagar
3. Assam - Dispur
4. Bihar - Patna
5. Chhattisgarh - Raipur
6. Goa - Panaji
7. Gujarat - Gandhinagar
8. Haryana - Chandigarh
9. Himachal Pradesh - Shimla (Summer), Dharamshala (Winter)
10. Jharkhand - Ranchi
11. Karnataka - Bengaluru
12. Kerala - Thiruvananthapuram
13. Madhya Pradesh - Bhopal
14. Maharashtra - Mumbai
15. Manipur - Imphal
16. Meghalaya - Shillong
17. Mizoram - Aizawl
18. Nagaland - Kohima
19. Odisha - Bhubaneswar
20. Punjab - Chandigarh
21. Rajasthan - Jaipur
22. Sikkim - Gangtok
23. Tamil Nadu - Chennai
24. Telangana - Hyderabad
25. Tripura - Agartala
26. Uttar Pradesh - Lucknow
27. Uttarakhand - Dehradun (Winter), Gairsain (Summer)
28. West Bengal - Kolkata

Please note that some states have more than one capital for different seasons, as indicated above.
```

```execute
http -b localhost:8080/chat/simple?query="You are a comedian. Can you write a short poem about Pune, India?"
```

```
In Pune where the auto-rickshaws zoom,  
And traffic jams are a daily doom.  
The weather's nice, not too much heat,  
But try crossing the road—it's quite the feat!  

Home of the vada pav and spicy misal,  
You'll need a strong stomach, or perhaps a missile.  
The Osho Ashram’s vibe is quite serene,  
While FC Road's chaos is a daily routine.  

With IT parks and wada architecture so grand,  
Pune’s where the modern and old hand in hand.  
So here’s to Pune, a city quite funny,  
Where the roads are bumpy, but the people are sunny!
```

```execute
http -b localhost:8080/chat/simple?query="You are a haiku writer. Can you write a short haiku about Pune? In Marati?" 
```

```
Here's a haiku in Marathi:

पुण्याची रात्री (Punechya Raatri)
सूरज सेतुवर (Surasetu Var)
माणसांचा हळू (Manasach Halu)

Translation:

Pune's night
Sunrise over the bridge
People's gentle dance
```

Feel free to play with various queries. 



#### Stop the Application

You can now stop the application in the second terminal.
```terminal:interrupt
session: 2
```
