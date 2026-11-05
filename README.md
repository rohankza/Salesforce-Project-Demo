# Salesforce Agentforce – Opportunity Management Agent
### Updated on November 05,2026
# Connect Facebook Messenger to Salesforce Agentforce

## 1. Project Overview

### Objective

Integrate Facebook Messenger with Salesforce Agentforce so customers can directly send messages to a Facebook Business Page and receive automated responses from an Agentforce Service Agent.

Customers do not need Salesforce or Experience Cloud access. They can simply visit the Facebook Business Page and ask questions.

### Business Scenario

Suppose a company provides customer support through Facebook Messenger.

A customer sends:

- "What is the status of Case 1016?"
- "What is the quantity of book Secret?"
- "What is the quantity of book Black Beauty?"

Salesforce Agentforce receives the messages, identifies the customer's request, executes the appropriate Flow action, retrieves the information, and sends the response back through Facebook Messenger.

### Expected Result

Customer sends a Facebook message → Salesforce Messaging Channel receives it → Omni-Channel Flow routes it to Agentforce → Agentforce processes the request → Customer receives a response on Facebook.

---

## 2. Prerequisites

Before starting the integration, prepare the following:

1. Salesforce org with Service Cloud and Agentforce capabilities.
2. An active Agentforce Service Agent.
3. Required Topics, Instructions, and Actions configured.
4. Einstein Service Agent User with the required permissions.
5. Omni-Channel enabled.
6. Routing Configuration created.
7. Fallback Queue created.
8. Inbound Omni-Channel Flow created and activated.
9. Facebook account with permission to manage a Facebook Page.
10. A Facebook Business Page.

---

## 3. Create an Agentforce Service Agent

### Step 1: Open Agentforce Studio

1. Log in to Salesforce.
2. Open Setup or App Launcher.
3. Search for Agentforce.
4. Open Agentforce Studio.
5. Navigate to Agents.
6. Click New Agent or open your existing Service Agent.

### Step 2: Configure the Agent

Create a Service Agent with the following example configuration:

| Setting | Value |
|---|---|
| Agent Name | Customer Support Agent |
| Agent Type | Service Agent |
| Purpose | Customer Support |
| Status | Active |

### Step 3: Configure Topics

Create two example Topics:

**Topic 1: Book Management**

Purpose: Retrieve book quantities based on the book name provided by the customer.

Example:
- Customer asks: What is the quantity of book Secret?
- Agentforce identifies the Book Management topic.
- Agentforce invokes the related Flow action.
- Flow retrieves the book quantity.
- Agentforce responds with the result.

**Topic 2: Case Management**

Purpose: Retrieve Case Status using the Case Number.

Example:
- Customer asks: What is the status of Case 1016?
- Agentforce identifies the Case Management topic.
- Agentforce invokes the Case Status action.
- Flow retrieves the Case record.
- Agentforce responds with the Case Status.

### Step 4: Configure Instructions and Actions

For each Topic:

1. Add appropriate instructions.
2. Define when the Topic should be selected.
3. Add the required Actions.
4. Connect the Actions to their respective Salesforce Flows.
5. Configure input and output variables.

Example Case Status Action:

| Parameter | Value |
|---|---|
| Input | Case Number |
| Flow | Check Case Status |
| Output | Case Status |

### Step 5: Activate the Agent

1. Save the Agent.
2. Commit the latest version.
3. Activate the Agent.

---

## 4. Assign Permissions to Einstein Service Agent User

Agentforce runs using its configured Einstein Service Agent User.

This user needs access to the Salesforce records and fields required by the Agent's Actions.

### Step 1: Find the Agent User

1. Go to Setup.
2. Search for Users.
3. Find the Einstein Service Agent User.
4. Open the user record.

### Step 2: Create a Permission Set

1. Go to Setup → Permission Sets.
2. Click New.
3. Enter the label: Custom Agent Permission Set.
4. Save.

### Step 3: Configure Object Permissions

For the Book custom object:

- Read
- Create
- Edit (only if required)

For the Case object:

- Read
- Create and Edit only if required by your use case.

### Step 4: Configure Field-Level Security

Give access to the fields required by your Flows.

Examples:

| Object | Field | Permission |
|---|---|---|
| Case | CaseNumber | Read |
| Case | Status | Read |
| Book | Name | Read |
| Book | Quantity | Read |

### Step 5: Assign the Permission Set

1. Open the Einstein Service Agent User.
2. Click Permission Set Assignments.
3. Assign Custom Agent Permission Set.
4. Save.

Also verify record-level access and Flow execution permissions.

---

## 5. Enable Omni-Channel

Omni-Channel manages the routing of customer conversations to the appropriate destination.

### Steps

1. Go to Setup.
2. Search for Omni-Channel Settings.
3. Open Omni-Channel Settings.
4. Enable Omni-Channel.
5. Enable Automatically Log Agents to Omni-Channel if required by your configuration.
6. Save.

---

## 6. Create a Routing Configuration

Routing Configuration defines how Salesforce routes work items to human support agents through queues.

### Steps

1. Go to Setup.
2. Search for Routing Configurations.
3. Click New.
4. Configure the following example values:

| Field | Example Value |
|---|---|
| Routing Configuration Name | Messaging Routing |
| Developer Name | Messaging_Routing |
| Routing Priority | 1 |
| Routing Model | Least Active |
| Units of Capacity | As required |

5. Save.

The Routing Configuration is used with the fallback queue so human agents can handle conversations if they are routed there.

---

## 7. Create a Fallback Queue

The fallback queue provides an alternative destination when the conversation cannot be routed successfully to the Agentforce Service Agent.

### Steps

1. Go to Setup.
2. Search for Queues.
3. Click New.
4. Configure:

| Field | Value |
|---|---|
| Label | Messaging Queue |
| Queue Name | Messaging_Queue |
| Supported Object | Messaging Session |
| Queue Members | Select support users |

5. Associate the Messaging Routing Configuration.
6. Save.

When a conversation is sent to this queue, an eligible human support agent can handle it according to the routing configuration and availability.

---

## 8. Create an Inbound Omni-Channel Flow

This is one of the most important steps.

The Inbound Omni-Channel Flow connects the Messaging Channel with the Agentforce Service Agent.

### Step 1: Create the Flow

1. Go to Setup → Flows.
2. Click New Flow.
3. Select Omni-Channel Flow.
4. Click Create.

### Step 2: Create the Record ID Variable

Open Manager → New Resource.

Configure:

| Field | Value |
|---|---|
| Resource Type | Variable |
| API Name | recordId |
| Data Type | Text |
| Available for Input | Checked |

This variable receives the Messaging Session record ID.

### Step 3: Add Route Work

1. Click the plus (+) icon.
2. Select Action.
3. Search for Route Work.
4. Select the Route Work action.

Configure:

| Field | Value |
|---|---|
| How Many Work Records to Route | Single |
| Record ID Variable | {!recordId} |
| Service Channel | Messaging |
| Route To | Agentforce Service Agent |
| Agentforce Service Agent | Customer Support Agent |
| Fallback Queue | Messaging Queue |

### Step 4: Save and Activate

1. Save the Flow.
2. Enter the Flow Label: Route to Agentforce.
3. Activate the Flow.

**Purpose:** When a customer sends a Facebook message, Salesforce passes the Messaging Session record ID to this Flow. The Route Work element routes the conversation to the selected Agentforce Service Agent.

---

## 9. Create a Facebook Business Page

A Facebook Business Page is required to connect Facebook Messenger with Salesforce.

**Important:** You need a Facebook Page, not just a personal Facebook profile. Your personal Facebook account can be used to create and manage the Page, but the Page is the communication channel that customers will message.

### Step 1: Log in to Facebook

1. Open https://www.facebook.com/.
2. Log in using your Facebook account.
3. Make sure your account has permission to create and manage Pages.

### Step 2: Open the Pages Section

1. Open the Facebook menu.
2. Navigate to Pages.
3. Select Create New Page.

The exact location of these options may vary depending on the Facebook interface.

### Step 3: Enter Page Information

Provide the following details:

| Field | Example Value |
|---|---|
| Page Name | Service Agent |
| Category | Customer Service |
| Description | Official customer support page for product and service-related queries. |

Click Create Page.

### Step 4: Customize the Facebook Page

After creating the Page:

1. Upload a profile picture or company logo.
2. Upload a cover image.
3. Add a business description.
4. Add contact information if required.
5. Configure the Page details.
6. Review the Page settings.

### Step 5: Verify Page Access

1. Open your newly created Facebook Page.
2. Go to Page Settings or Page Access.
3. Verify that your Facebook account has the required Page management permissions.
4. Make sure the account you will use for Salesforce authentication can access the Page.

### Step 6: Test the Page

1. Open the Page.
2. Use the View as visitor option if available.
3. Verify that the Page is accessible.
4. Confirm that customers can send a message.

**Expected Result:** Your Facebook Business Page is ready to connect with Salesforce.

---

## 10. Create a Facebook Messenger Messaging Channel in Salesforce

Now connect the Facebook Page to Salesforce.

### Step 1: Open Messaging Settings

1. Log in to Salesforce.
2. Go to Setup.
3. Search for Messaging Settings.
4. Open Messaging Settings.
5. Click New Channel.
6. Click Start.

### Step 2: Select Facebook Messenger

1. Select Facebook Messenger.
2. Click Next.
3. Review and accept the required terms and conditions.

### Step 3: Authenticate Facebook

1. Click Authenticate or Connect Facebook Account.
2. Log in using the Facebook account that manages your Business Page, if prompted.
3. Authorize Salesforce to access the required Facebook Page information.
4. Complete the authentication process.

### Step 4: Select the Facebook Page

After authentication, Salesforce displays the Pages available to your Facebook account.

1. Select the Service Agent Facebook Page.
2. Verify the Page name.
3. Verify the Page ID.
4. Click Next.

### Step 5: Configure Chat Acknowledgement

Set an initial acknowledgement message.

Example:

"Thanks for messaging us. An agent will be with you shortly."

This message acknowledges that Salesforce has received the customer's message.

### Step 6: Select Message Routing

Salesforce asks how you want to route messages to your support team.

Select:

**Omni-Flow**

This allows the Messaging Channel to use the Inbound Omni-Channel Flow created earlier.

Click Next and complete the remaining channel creation steps.

### Step 7: Save the Messaging Channel

After completing the setup wizard, Salesforce creates the Messaging Channel.

At this stage, the channel may not yet be active.

---

## 11. Configure the Messaging Channel Routing

After creating the channel, open its settings.

Configure the routing details:

| Field | Value |
|---|---|
| Routing Type | Omni-Flow |
| Flow Definition | Route to Agentforce |
| Fallback Queue | Messaging Queue |

1. Save the configuration.
2. Verify that the correct Flow is selected.
3. Verify that the fallback queue is selected.
4. Click Activate.

**Expected Result:** The Facebook Messenger Messaging Channel is now active and connected to the Inbound Omni-Channel Flow.

---

## 12. Configure Messaging Consent Settings

Messaging consent settings manage customer permission to receive messages.

The video demonstrates three consent types.

### A. Implicit Opt-In

The customer starts the conversation without an additional opt-in confirmation.

### B. Explicit Opt-In

The customer sends the first message.

Salesforce asks the customer to confirm permission by replying with a keyword such as YES.

After receiving confirmation, the customer can continue the conversation.

### C. Double Opt-In

The customer must confirm twice.

Example:

| Step | Message |
|---|---|
| 1 | Customer sends: Hello |
| 2 | Salesforce asks the customer to reply YES |
| 3 | Customer replies: YES |
| 4 | Salesforce asks for a second confirmation |
| 5 | Customer replies: START |
| 6 | Salesforce confirms successful opt-in |

Example configuration:

**Opt-In Prompt:**

"Thanks for connecting with us. To opt in to receive messages, please reply YES."

**Double Opt-In Confirmation Prompt:**

"To confirm your response, reply START."

**Successful Opt-In Message:**

"Thanks for opting in and allowing us to send you messages."

### Configure Opt-In Keywords

1. Open the Messaging Channel settings.
2. Find Consent Settings.
3. Select the consent type.
4. Configure the opt-in messages.
5. Open the channel language settings.
6. Select Edit Language.
7. Configure the opt-in keywords.

Example:

- Initial opt-in keyword: YES
- Double opt-in keyword: START

### Configure Opt-Out Keywords

Examples:

- STOP
- CANCEL
- STOP ALL
- UNSUBSCRIBE
- QUIT

Configure an appropriate opt-out confirmation message.

Example:

"You have successfully unsubscribed from receiving messages."

Save the configuration.

**Note:** Consent settings and supported keywords should be configured according to the channel's current Salesforce requirements and applicable messaging policies.

---

## 13. Test Facebook Messenger with Agentforce

Now test the complete integration.

### Step 1: Open Facebook

1. Log in using a personal Facebook account.
2. Open the Service Agent Facebook Business Page.
3. Click Message.
4. Start a conversation.

### Step 2: Test Consent

If Double Opt-In is enabled:

1. Send: Hello.
2. Salesforce sends the initial opt-in prompt.
3. Reply: YES.
4. Salesforce sends the second confirmation prompt.
5. Reply: START.
6. Salesforce sends the successful opt-in confirmation.

### Step 3: Verify Agentforce Welcome Message

After consent is completed, Agentforce should join the conversation and send its welcome message.

Example:

"Hi, I am an AI Service Assistant. How can I help you?"

### Step 4: Test Case Management

Send:

"What is the status of Case 1016?"

Expected processing:

1. Agentforce receives the message.
2. It selects the Case Management Topic.
3. It extracts Case Number 1016.
4. It invokes the Case Status Action.
5. The Flow retrieves the Case record.
6. The Flow returns the Case Status.
7. Agentforce generates a response.

Example response:

"The status of Case 1016 is Working."

### Step 5: Test Book Management

Send:

"What is the quantity of book Secret?"

Expected response:

"The quantity of book Secret is 100."

Send another message:

"What is the quantity of book Black Beauty?"

Expected response:

"The quantity of book Black Beauty is 50."

**Expected Result:** Agentforce successfully retrieves Salesforce information and responds through Facebook Messenger.

---

## 14. Monitor Facebook Messages Using Messaging Sessions

Salesforce provides Messaging Sessions to monitor customer conversations.

### Step 1: Open Messaging Sessions

1. Open App Launcher.
2. Search for Messaging Sessions.
3. Open the Messaging Sessions object.
4. Create or select an appropriate list view.
5. Select All Messaging Sessions.

### Step 2: Open a Messaging Session

1. Find the conversation created from your Facebook Page.
2. Open the Messaging Session record.
3. Verify the customer conversation details.

### Step 3: Configure Enhanced Conversation

To view the complete conversation:

1. Open the Messaging Session page.
2. Go to the page layout or Lightning Record Page configuration.
3. Open Lightning App Builder.
4. Add the Enhanced Conversation component where supported.
5. Save.
6. Activate the page.

### Step 4: Verify the Conversation

The Messaging Session should display the conversation history, including:

- Customer's initial message.
- Consent confirmation messages.
- Customer's YES response.
- Customer's START response.
- Agentforce welcome message.
- Customer's Case Status request.
- Agentforce's Case Status response.
- Book Management requests and responses.

Where configured, users can also associate relevant records such as Contacts, Cases, Leads, or Opportunities with a Messaging Session.

**Expected Result:** Administrators and support users can monitor customer conversations in Salesforce.



### Updated on November 03,2026

## 1. Show My Open Opportunities

### Step 1: Create Flow
- Open **Setup → Flows → New Flow**.
- Select **Autolaunched Flow (No Trigger)**.
- Name: `Get_Open_Opportunities`.

### Step 2: Create Variables
- Create a Record Collection variable named `varOpenOpportunities`.
- Object: Opportunity.
- Enable **Available for Output**.
- Use the current running user's ID to identify their records.

### Step 3: Get Opportunity Records
- Add a **Get Records** element.
- Object: Opportunity.
- Conditions:
  - `IsClosed = False`
  - `OwnerId = Current User ID`
- Select **All Records**.

### Step 4: Assign Output
- Add an **Assignment** element.
- Assign the records returned by Get Records to `varOpenOpportunities`.

### Step 5: Save and Activate
- Save the Flow and click **Activate**.

### Step 6: Connect with Agentforce
- Open Agentforce Builder.
- Create or select the Opportunity Management Subagent.
- Add a new Flow Action.
- Select `Get_Open_Opportunities`.
- Configure the output to show in the conversation.

### Step 7: Test
Use this prompt:

`Show me my open opportunities.`

The agent retrieves and displays the current user's open Opportunity records.

---

## 2. Create a New Opportunity

### Step 1: Create Flow
- Open **Setup → Flows → New Flow**.
- Select **Autolaunched Flow (No Trigger)**.
- Name: `Create_Opportunity`.

### Step 2: Create Input Variables
Create the following variables and enable **Available for Input**:

| Variable | Data Type |
|---|---|
| `varOppName` | Text |
| `varStageName` | Text |
| `varCloseDate` | Date |
| `varAmount` | Currency |

### Step 3: Add Create Records
- Add a **Create Records** element.
- Select **One** Opportunity record.
- Set the following fields:

| Opportunity Field | Flow Value |
|---|---|
| Name | `varOppName` |
| StageName | `varStageName` |
| CloseDate | `varCloseDate` |
| Amount | `varAmount` |
| OwnerId | Current User ID |

### Step 4: Save and Activate
- Save the Flow.
- Click **Activate**.

### Step 5: Connect with Agentforce
- Open Agentforce Builder.
- Go to the Opportunity Management Subagent.
- Add a new Flow Action.
- Select `Create_Opportunity`.
- Configure the input variables and output as required.
- Resolve any input data type validation issues before testing.

### Step 6: Add Agent Instructions
Tell the agent to:
- Ask for Opportunity Name, Stage, Close Date, and Amount.
- Ask the user for any missing required information.
- Execute the Flow after collecting the details.
- Confirm creation only after the Flow succeeds.

### Step 7: Test
Use this prompt:

`Create an Opportunity named ABC Project with stage Qualification, close date 30 December 2026, and amount 50000.`

The agent should create the Opportunity and confirm the result.

---

