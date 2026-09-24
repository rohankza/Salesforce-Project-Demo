import { LightningElement, api, wire } from 'lwc';

import getFile from '@salesforce/apex/AccountFileViewerController.getFile';

export default class PdfViewer extends LightningElement {

    @api contentVersionId;

    fileName;
    pdfUrl;

    // Your PDF has 6100 pages
    totalPages = 6100;

    currentPage = 1;
    pageInput = 1;

    /*
     * Get Salesforce File
     */
    @wire(getFile, {
        contentVersionId: '$contentVersionId'
    })
    wiredFile({ data, error }) {

        if (data) {

            this.fileName = data.Title;

            /*
             * Salesforce direct ContentVersion URL
             */
            this.pdfUrl =
                '/sfc/servlet.shepherd/version/download/' +
                data.Id;

            console.log('PDF URL:', this.pdfUrl);
            console.log('File:', data.Title);
            console.log('Size:', data.ContentSize);

        }

        if (error) {

            console.error(
                'Error getting PDF:',
                error
            );
        }
    }


    /*
     * This URL opens the PDF
     * at the selected page.
     */
    get viewerUrl() {

        if (!this.pdfUrl) {
            return null;
        }

        return `${this.pdfUrl}#page=${this.currentPage}`;
    }


    /*
     * Previous Page
     */
    handlePrevious() {

        if (this.currentPage <= 1) {
            return;
        }

        this.currentPage--;

        this.pageInput = this.currentPage;

    }


    /*
     * Next Page
     */
    handleNext() {

        if (this.currentPage >= this.totalPages) {
            return;
        }

        this.currentPage++;

        this.pageInput = this.currentPage;

    }


    /*
     * Input Page Number
     */
    handlePageInput(event) {

        this.pageInput =
            Number(event.target.value);

    }


    /*
     * Go To Page
     */
    handleGoToPage() {

        let page =
            Number(this.pageInput);

        if (!page) {
            return;
        }

        /*
         * Prevent page less than 1
         */
        if (page < 1) {
            page = 1;
        }

        /*
         * Prevent page greater than 6100
         */
        if (page > this.totalPages) {
            page = this.totalPages;
        }

        this.currentPage = page;

        this.pageInput = page;

    }


    /*
     * First page
     */
    get isFirstPage() {

        return this.currentPage === 1;

    }


    /*
     * Last page
     */
    get isLastPage() {

        return this.currentPage === this.totalPages;

    }


    /*
     * Optional:
     * Open PDF in a new browser tab
     */
    openPdf() {

        if (!this.pdfUrl) {
            return;
        }

        window.open(
            `${this.pdfUrl}#page=${this.currentPage}`,
            '_blank'
        );
    }

}