---
title: Embedding Models
---

#### Embedding Model

**Embedding Model** is a machine learning model that converts high-dimensial data,
such as text, images, and videos into a lower-dimensional numberical representation
in a form of floating point numbers, vectors - also known as embeddings. These
embeddings capture semantic relationships, meaning the similar words, phrases, or
documents have embeddings that are close together in vector space.

By calculating the numerical distance between vector representations, we can
determine the contextual similarity between the objects used to generate the
embedding vectors.

Read more about [Embedding Model API](https://docs.spring.io/spring-ai/reference/api/embeddings.html).

#### Vector Databases

We use a **VectorStore** to store embeddings. There are number of implementations
of the **VectorStore**, including a **SimpleVectorStore** an in-memory vector database.

We have created **SimpleVectorStoreConfig** to initialize the **SimpleVectorStore**

```editor:open-file
file: ~/spring-ai-intro/src/main/java/dev/tanzu/demo/SimpleVectorStoreConfig.java
description: Open SimpleVectorStoreConfig
line: 25
```

Alternatively, you could leverage **Redis** or **Pgvector** vector database to get
better performance when embedding and searching.

#### Create Embeddings

For purpose of this lab, we have hardcoded data in a JSON file on the classpath.

We will use data collected from a sample survey, to be used later on, e.g.
* timestamp
* name
* email
* score
* feedback

See the example data, e.g.

```editor:open-file
file: ~/spring-ai-intro/src/main/resources/data/feedback.json
description: Open data/feedback.json
line: 1
```

We are loading the JSON file on-demand through a **LoadController**, e.g.

```editor:open-file
file: ~/spring-ai-intro/src/main/java/dev/tanzu/demo/feedback/LoadController.java
description: Open LoadController.loadJson method
line: 35
```

We are using **JsonReader** to get a list of **Document** objects
that we will store in **SimpleVectorStore**, e.g.

```editor:select-matching-text
file: ~/spring-ai-intro/src/main/java/dev/tanzu/demo/feedback/LoadController.java
description: Find line where we read a list of documents
text: "List<Document> documents = reader.get();"
```

```editor:select-matching-text
file: ~/spring-ai-intro/src/main/java/dev/tanzu/demo/feedback/LoadController.java
description: Find line where we save the vector store
text: "this.vectorStore.add(documents);"
```

We could use advanced indexing and tagging of the data before saving it to
a vector store, but for the purpose of this lab, we will keep it simple.

#### Run the application (again)

Let's run the application if you have stopped it in the previous lab, e.g.

```terminal:execute
command: ./mvnw spring-boot:run
session: 2
```

{{< note >}}
Please wait for the Spring application to finish in lower terminal, e.g. **Started AiApplication in ...**
{{< /note >}}

#### Load the vector store

Let's run a query to load the JSON data and store embeddings in the vector store, e.g.

```execute
http -b localhost:8080/feedback/load/json
```

```
vector store loaded with 25 documents.
```

{{< warning >}}
🛑 Don't stop the application, because you will need to load the data again since
we are using an in-memory **SimpleVectorStore** that is cleared on JVM exit.
{{< /warning >}}


```section:begin
title: Explore the log file
```

```
2025-02-03T10:10:51.164+01:00  INFO 96951 --- [spring-ai-intro] [nio-8080-exec-3] dev.tanzu.demo.raffle.LoadController     : Loading entries from file:.../spring-ai-intro/target/classes/data/entries.json
2025-02-03T10:10:51.227+01:00  INFO 96951 --- [spring-ai-intro] [nio-8080-exec-3] dev.tanzu.demo.raffle.LoadController     : Adding 30 documents to the vector store SimpleVectorStore
2025-02-03T10:10:52.237+01:00  INFO 96951 --- [spring-ai-intro] [nio-8080-exec-3] o.s.ai.vectorstore.SimpleVectorStore     : Calling EmbeddingModel for document id = 41575d20-9793-4919-9b0c-435d2c74fd95
2025-02-03T10:10:52.274+01:00  INFO 96951 --- [spring-ai-intro] [nio-8080-exec-3] o.s.ai.vectorstore.SimpleVectorStore     : Calling EmbeddingModel for document id = 9ee2d04b-5a0d-4f0e-8781-42b525698793
2025-02-03T10:10:52.302+01:00  INFO 96951 --- [spring-ai-intro] [nio-8080-exec-3] o.s.ai.vectorstore.SimpleVectorStore     : Calling EmbeddingModel for document id = 5b810017-ae58-4782-9862-bdc1d4a06934
2025-02-03T10:10:52.332+01:00  INFO 96951 --- [spring-ai-intro] [nio-8080-exec-3] o.s.ai.vectorstore.SimpleVectorStore     : Calling EmbeddingModel for document id = bad1aaf8-2334-4256-acaa-592db0b6f765
2025-02-03T10:10:52.363+01:00  INFO 96951 --- [spring-ai-intro] [nio-8080-exec-3] o.s.ai.vectorstore.SimpleVectorStore     : Calling EmbeddingModel for document id = 3a065063-f616-4755-8186-ec23ac5b1155
2025-02-03T10:10:52.410+01:00  INFO 96951 --- [spring-ai-intro] [nio-8080-exec-3] o.s.ai.vectorstore.SimpleVectorStore     : Calling EmbeddingModel for document id = 8538ad30-d47e-48e3-b206-315bb2ab3128
2025-02-03T10:10:52.467+01:00  INFO 96951 --- [spring-ai-intro] [nio-8080-exec-3] o.s.ai.vectorstore.SimpleVectorStore     : Calling EmbeddingModel for document id = 2be626f7-9d23-4f07-9f53-1337707cb0f2
2025-02-03T10:10:52.501+01:00  INFO 96951 --- [spring-ai-intro] [nio-8080-exec-3] o.s.ai.vectorstore.SimpleVectorStore     : Calling EmbeddingModel for document id = 6a7a3c8f-ec3d-41de-95f3-95bf2f911a1e
2025-02-03T10:10:52.539+01:00  INFO 96951 --- [spring-ai-intro] [nio-8080-exec-3] o.s.ai.vectorstore.SimpleVectorStore     : Calling EmbeddingModel for document id = 7a322630-834a-49f9-a17b-5d9eaa0a74f1
2025-02-03T10:10:52.562+01:00  INFO 96951 --- [spring-ai-intro] [nio-8080-exec-3] o.s.ai.vectorstore.SimpleVectorStore     : Calling EmbeddingModel for document id = 86560bc7-bfe1-4554-88e3-786e49405c21
2025-02-03T10:10:52.589+01:00  INFO 96951 --- [spring-ai-intro] [nio-8080-exec-3] o.s.ai.vectorstore.SimpleVectorStore     : Calling EmbeddingModel for document id = 14c64bd5-57e5-42f3-9f07-988b896a0bcd
2025-02-03T10:10:52.621+01:00  INFO 96951 --- [spring-ai-intro] [nio-8080-exec-3] o.s.ai.vectorstore.SimpleVectorStore     : Calling EmbeddingModel for document id = a485c993-dedb-4ca3-a9fd-398ff35c388b
2025-02-03T10:10:52.654+01:00  INFO 96951 --- [spring-ai-intro] [nio-8080-exec-3] o.s.ai.vectorstore.SimpleVectorStore     : Calling EmbeddingModel for document id = 9c011912-c68a-499a-b934-5c6e6096267c
2025-02-03T10:10:52.695+01:00  INFO 96951 --- [spring-ai-intro] [nio-8080-exec-3] o.s.ai.vectorstore.SimpleVectorStore     : Calling EmbeddingModel for document id = 2e2d7580-129a-4b08-b441-2e29a871d3b3
2025-02-03T10:10:52.743+01:00  INFO 96951 --- [spring-ai-intro] [nio-8080-exec-3] o.s.ai.vectorstore.SimpleVectorStore     : Calling EmbeddingModel for document id = 78bb077a-5528-4c49-9d19-c42ca421f6c8
2025-02-03T10:10:52.785+01:00  INFO 96951 --- [spring-ai-intro] [nio-8080-exec-3] o.s.ai.vectorstore.SimpleVectorStore     : Calling EmbeddingModel for document id = 6e23e16f-3799-4bfa-9e3b-b24db2177359
2025-02-03T10:10:52.823+01:00  INFO 96951 --- [spring-ai-intro] [nio-8080-exec-3] o.s.ai.vectorstore.SimpleVectorStore     : Calling EmbeddingModel for document id = 70ec4a7d-683a-473e-b642-1382ed8c68e4
2025-02-03T10:10:52.873+01:00  INFO 96951 --- [spring-ai-intro] [nio-8080-exec-3] o.s.ai.vectorstore.SimpleVectorStore     : Calling EmbeddingModel for document id = 66dc4cf0-8e64-4b53-a0d5-312dbea73d49
2025-02-03T10:10:52.969+01:00  INFO 96951 --- [spring-ai-intro] [nio-8080-exec-3] o.s.ai.vectorstore.SimpleVectorStore     : Calling EmbeddingModel for document id = 43f75e5b-b12a-41f3-af83-e169a44f636e
2025-02-03T10:10:53.019+01:00  INFO 96951 --- [spring-ai-intro] [nio-8080-exec-3] o.s.ai.vectorstore.SimpleVectorStore     : Calling EmbeddingModel for document id = e363a3ab-d94a-4ee6-ac32-8ac5b8142b04
2025-02-03T10:10:53.068+01:00  INFO 96951 --- [spring-ai-intro] [nio-8080-exec-3] o.s.ai.vectorstore.SimpleVectorStore     : Calling EmbeddingModel for document id = 3869f81e-0f38-4fb1-9ac7-95291d926f4e
2025-02-03T10:10:53.140+01:00  INFO 96951 --- [spring-ai-intro] [nio-8080-exec-3] o.s.ai.vectorstore.SimpleVectorStore     : Calling EmbeddingModel for document id = ea2f1da7-6332-48ab-bbb0-e590d6a9bc2f
2025-02-03T10:10:53.205+01:00  INFO 96951 --- [spring-ai-intro] [nio-8080-exec-3] o.s.ai.vectorstore.SimpleVectorStore     : Calling EmbeddingModel for document id = 6004730f-5eba-4c84-8d63-195879ba3965
2025-02-03T10:10:53.258+01:00  INFO 96951 --- [spring-ai-intro] [nio-8080-exec-3] o.s.ai.vectorstore.SimpleVectorStore     : Calling EmbeddingModel for document id = dbcb8685-4b84-4171-bbdf-f8004614075f
2025-02-03T10:10:53.310+01:00  INFO 96951 --- [spring-ai-intro] [nio-8080-exec-3] o.s.ai.vectorstore.SimpleVectorStore     : Calling EmbeddingModel for document id = 107ebaf5-f19d-4d31-8771-ca4983fa0a99
2025-02-03T10:10:53.362+01:00  INFO 96951 --- [spring-ai-intro] [nio-8080-exec-3] o.s.ai.vectorstore.SimpleVectorStore     : Calling EmbeddingModel for document id = 19bbfa23-a0f5-4aa5-b063-8b30bf736162
2025-02-03T10:10:53.415+01:00  INFO 96951 --- [spring-ai-intro] [nio-8080-exec-3] o.s.ai.vectorstore.SimpleVectorStore     : Calling EmbeddingModel for document id = 2820cd89-8736-484b-ba93-0e0a88619c07
2025-02-03T10:10:53.462+01:00  INFO 96951 --- [spring-ai-intro] [nio-8080-exec-3] o.s.ai.vectorstore.SimpleVectorStore     : Calling EmbeddingModel for document id = 56a8991e-0d09-40a4-9b21-28b492109b92
2025-02-03T10:10:53.506+01:00  INFO 96951 --- [spring-ai-intro] [nio-8080-exec-3] o.s.ai.vectorstore.SimpleVectorStore     : Calling EmbeddingModel for document id = 523dd3af-2731-4ff0-8ffe-06fb4f86a50f
2025-02-03T10:10:53.545+01:00  INFO 96951 --- [spring-ai-intro] [nio-8080-exec-3] o.s.ai.vectorstore.SimpleVectorStore     : Calling EmbeddingModel for document id = d3302ef0-0d66-4484-a190-2d70d0f17d3f
```

```section:end
```

Now that we have loaded documents into vector store, we can use that in our next lab - RAG!

{{< note >}}
Feel free to [continue with optional steps](../07-retrieval-augmented-generation) or go to

[🏁 Workshop Summary 🏁](../99-workshop-summary)
{{< /note >}}
