import { LightningElement } from 'lwc';

import runQuery from '@salesforce/apex/SoqlQueryController.runQuery';
import generateSoql from '@salesforce/apex/SoqlGeneratorController.generateSoql';

export default class SoqlAssistant extends LightningElement {
    // English requirement input
    requirement = '';

    // SOQL query editor
    query = 'SELECT Id, Name FROM Account LIMIT 10';

    // Query results
    tableColumns = [];
    tableRows = [];
    totalRows = 0;

    // UI state
    errorMessage = '';
    successMessage = '';
    isLoading = false;
    isGenerating = false;

    // Currently supported object
    objectName = 'Account';

    get hasResults() {
        return this.tableRows.length > 0;
    }

    get isBusy() {
        return this.isLoading || this.isGenerating;
    }

    // Handle English requirement input
    handleRequirementChange(event) {
        this.requirement = event.target.value;
        this.errorMessage = '';
        this.successMessage = '';
    }

    // Handle manual SOQL editing
    handleQueryChange(event) {
        this.query = event.target.value;
        this.errorMessage = '';
        this.successMessage = '';
    }

    // Generate SOQL using OpenAI through Apex
    async handleGenerateSoql() {
        if (!this.requirement || !this.requirement.trim()) {
            this.errorMessage =
                'Please describe what records you want to retrieve.';
            return;
        }

        this.isGenerating = true;
        this.errorMessage = '';
        this.successMessage = '';

        try {
            const generatedQuery = await generateSoql({
                requirement: this.requirement,
                objectName: this.objectName
            });

            if (
                !generatedQuery ||
                !generatedQuery.trim().toUpperCase().startsWith('SELECT ')
            ) {
                throw new Error(
                    'The AI did not return a valid SELECT query.'
                );
            }

            // Populate the existing SOQL editor.
            // The query is not automatically executed.
            this.query = generatedQuery.trim();
            this.tableColumns = [];
            this.tableRows = [];
            this.totalRows = 0;

            this.successMessage =
                'SOQL generated. Review the query before running it.';

        } catch (error) {
            this.errorMessage =
                error?.body?.message ||
                error?.message ||
                'Unable to generate SOQL. Check your API configuration.';
        } finally {
            this.isGenerating = false;
        }
    }

    // Execute the query through the existing Apex controller
    async handleRunQuery() {
        if (!this.query || !this.query.trim()) {
            this.errorMessage = 'Please enter a SOQL query.';
            return;
        }

        this.isLoading = true;
        this.errorMessage = '';
        this.successMessage = '';
        this.tableColumns = [];
        this.tableRows = [];
        this.totalRows = 0;

        try {
            const result = await runQuery({
                soql: this.query.trim()
            });

            this.totalRows = result.totalRows || 0;

            this.tableColumns = (result.columns || []).map(field => ({
                label: field,
                fieldName: field,
                type: 'text'
            }));

            this.tableRows = (result.rows || []).map((row, index) => ({
                ...row,
                rowId: String(index)
            }));

            this.successMessage =
                `Query executed successfully. Records returned: ${this.totalRows}.`;

        } catch (error) {
            this.errorMessage =
                error?.body?.message ||
                error?.message ||
                'Unable to execute query. Check your SOQL and permissions.';
        } finally {
            this.isLoading = false;
        }
    }
}