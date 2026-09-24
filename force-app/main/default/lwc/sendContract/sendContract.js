import { LightningElement, api, track } from 'lwc';

import sendDocument from '@salesforce/apex/DocuSignController.sendDocument';
import checkEnvelopeStatus from '@salesforce/apex/DocuSignController.checkEnvelopeStatus';
import downloadSignedPdf from '@salesforce/apex/DocuSignController.downloadSignedPdf';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class SendContract extends LightningElement {

    @api recordId;
         envelopeRecordId
    @track recipientName='';
    @track recipientEmail='';

    contentVersionId;
    fileName;

    handleName(event){
        this.recipientName=event.target.value;
    }

    handleEmail(event){
        this.recipientEmail=event.target.value;
    }

    handleUploadFinished(event){

        const uploadedFiles = event.detail.files;

        this.fileName = uploadedFiles[0].name;

        this.contentVersionId = uploadedFiles[0].contentVersionId;

        console.log(this.contentVersionId);

    }

    sendContract(){


        console.log('Opportunity',this.recordId);
        console.log(this.recipientEmail);

        if(!this.contentVersionId){

            this.dispatchEvent(
                new ShowToastEvent({
                    title:'Error',
                    message:'Please upload a PDF first.',
                    variant:'error'
                })
            );

            return;

        }

        sendDocument({
            opportunityId:this.recordId,
            contentVersionId:this.contentVersionId,
            recipientName:this.recipientName,
            recipientEmail:this.recipientEmail

        })

        .then(result=>{

    this.envelopeRecordId = result;

    console.log('Envelope Record Id : ' + this.envelopeRecordId);

            this.dispatchEvent(
                new ShowToastEvent({
                    title:'Success',
                    message:'Document Sent Successfully',
                    variant:'success'
                })
            );

            console.log(result);

        })

        .catch(error=>{

            this.dispatchEvent(
                new ShowToastEvent({
                    title:'Error',
                    message:error.body.message,
                    variant:'error'
                })
            );

        });

    }


    checkStatus(){
    console.log('Check status running');

    checkEnvelopeStatus({

        envelopeRecordId : this.envelopeRecordId

    })

    .then(result=>{

        console.log('Status : ' + result);

        this.dispatchEvent(
            new ShowToastEvent({
                title:'Envelope Status',
                message: result,
                variant:'success'
            })
        );

        if(result === 'completed'){

            console.log('Customer has signed the document.');

             downloadSignedPdf({

        envelopeRecordId : this.envelopeRecordId

    })

    .then(result=>{

        this.dispatchEvent(
            new ShowToastEvent({
                title:'Success',
                message:result,
                variant:'success'
            })
        );

    })

    .catch(error=>{

        this.dispatchEvent(
            new ShowToastEvent({
                title:'Error',
                message:error.body.message,
                variant:'error'
            })
        );

    });
        }

    })

    .catch(error=>{

        console.error(error);

        this.dispatchEvent(
            new ShowToastEvent({
                title:'Error',
                message:error.body.message,
                variant:'error'
            })
        );

    });

}

    

}