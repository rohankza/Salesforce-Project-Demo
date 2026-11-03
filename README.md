# Salesforce Agentforce – Opportunity Management Agent
### Updated Date:November 03,2026

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

