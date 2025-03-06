---
title: Welcome to Barclays Spring Day 2025
---

Welcome to the Barclays Spring Day event in Oxford of the East, Pune, India.

### Prerequisites
 
- You can read Java code.
- Familiarity with Spring
- API Key to access to LLMS (Optional)

### How to Get API Key (Optional)

Here are some of the popular sites that offer free API keys to test out the models. It's here for reference. If you decide to use one of them you have to update the `pom.xml` with the right boot starter and configure the `application.yaml` to reflect the same.

#### Google Gemini

- Log in to your Google account.
- Visit the Google AI website (https://aistudio.google.com/)
- Click on the Solutions on the top left and select `Google AI Studio`
- Click on the `Get API key` button, usually located in the top left corner of the page.
- When the API Keys page loads, click on `Create API key`.
- Review and accept the Google API Terms of Service and Gemini API Additional Terms of Service.
- Your API key will be generated. Copy it immediately and store it securely, as this is the only time you'll see it in full.

    ##### Validate 

    export LLM_API_KEY=`<YOUR API KEY>`
    ````execute
    curl "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$LLM_API_KEY" \
    -sH 'Content-Type: application/json' \
    -X POST \
    -d '{
    "contents": [{
        "parts":[{"text": "Who are you"}]
        }]
    }' | jq .candidates[].content.parts[].text
    ````

#### Hugging Face

- Visit the Hugging Face website (https://huggingface.co) and sign up for an account if you don't have one already.
- Log in to your Hugging Face account.
- Click on your profile icon in the top right corner of the page.
- Select `Settings` from the dropdown menu.
- In the left panel, click on `Access Tokens`
- On the Access Tokens page, click the `Create New Token` button.
- Click the `Read` tab or section.
- Choose a name for your token (e.g., `Spring AI Workshop`)
- Click "Generate" to create your API key.
- Copy the generated API key immediately and store it securely. This is the only time you'll see the full key.

    ##### Validate 

    export LLM_API_KEY=`<YOUR API KEY>`
    ````execute
    curl https://api-inference.huggingface.co/models/openai-community/gpt2 \
    -X POST \
    -sH "Content-Type: application/json" \
    -H "Authorization: Bearer $LLM_API_KEY" \
    -d '{"inputs": "Who are you"}' | jq .[].generated_text
    ````

#### Groq

- Visit the Groq Console website at (https://console.groq.com/)
- Sign up for a new account if you don't have one, or log in to your existing account.
- Once logged in, navigate to the API Keys section in the left sidebar.
- Click on the `Create API Key` button.
- In the pop-up window, enter a display name for your API key (e.g., `Spring AI Workshop`).
- Click `Submit` to generate your API key.
- Copy the generated API key immediately and store it securely. This is the only time you'll see the full key.

    ##### Validate 

    export LLM_API_KEY=`<YOUR API KEY>`
    ````execute
    curl https://api.groq.com/openai/v1/chat/completions -s \
    -sH "Content-Type: application/json" \
    -H "Authorization: Bearer $LLM_API_KEY" \
    -d '{
    "model": "llama-3.3-70b-versatile",
    "messages": [{
        "role": "system",
        "content": "Tell me about yourself."
    }]
    }' | jq .choices[0].message.content
    ````

Please ask any staff if you run into any issues.

**Enjoy the lab!**
