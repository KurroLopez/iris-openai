# Banksia-openai
OpenAI IRIS Interoperability Business Operation based on great work by Kurro Lopez at https://github.com/KurroLopez/iris-openai

## The idea
You will get a single business operation Banksia.OpenAi.Operation which supports all API calls by OpenAI API: chat, images, audio etc

## Prerequisites
You will need OpenAI API key and a little balance on your OpenAI account to test this operation. See details here https://platform.openai.com/docs/quickstart?context=curl

## Installation 

- Install using ZPM 

```
zpm "install banksia-openai"
```

Alternatively just load "src/Banksia" folder into your IRIS instance.

## How to use it
Step 1: Create your production and insert a new Business Operation called "Banksia.OpenAi.OpenAi" using the class with the same name.

![](Add_Banksia.OpenAi.Operation.gif)

Step 2: Modify the component's properties to include the Secret Key and OrganizationID

![](Configure_Banksia.OpenAi.Operation.png)

## How to Test it
There is a demo created in this composition to check the connection with OpenAI.

Also, there is a Postman collection exported to test. It's prepared to connect with Docker compose.

![](Demo.OpenAi.Postman.png)