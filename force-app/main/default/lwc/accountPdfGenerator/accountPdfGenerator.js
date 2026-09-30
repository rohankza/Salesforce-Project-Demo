import { LightningElement, api } from 'lwc';
import generateAccountPdf from '@salesforce/apex/AccountPdfGenerator.generateAccountPdf';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class AccountPdfGenerator extends LightningElement {
    @api recordId;

    

    handleGenerate() {
       
        generateAccountPdf({ accountId: this.recordId })
            .then(docId => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'PDF generated successfully.\nDocument Id: ' + docId,
                        variant: 'success'
                    })
                );

                console.log('ContentDocumentId:', docId);
                 alert('asdf');
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error',
                        message: error.body.message,
                        variant: 'error'
                    })
                );
            });
    }
}