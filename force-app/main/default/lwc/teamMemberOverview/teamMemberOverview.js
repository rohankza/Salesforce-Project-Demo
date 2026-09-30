import { LightningElement, wire } from 'lwc';

import getEmployees
    from '@salesforce/apex/TeamMemberOverviewController.getEmployees';

import getTasks
    from '@salesforce/apex/TeamMemberOverviewController.getTasks';


export default class TeamMemberOverview extends LightningElement {

    employees = [];
    tasks = [];

    displayData = [];

    searchKey = '';

    // Modal
    showEmployeeModal = false;
    selectedEmployee = null;
    selectedEmployeeTasks = [];


    // =====================================================
    // GET EMPLOYEES
    // =====================================================

    @wire(getEmployees)
    wiredEmployees({ data, error }) {

        if (data) {

            this.employees = data;

            this.prepareData();

        } else if (error) {

            console.error('Employee Error:', error);

        }

    }


    // =====================================================
    // GET TASKS
    // =====================================================

    @wire(getTasks)
    wiredTasks({ data, error }) {

        if (data) {

            this.tasks = data;

            this.prepareData();

        } else if (error) {

            console.error('Task Error:', error);

        }

    }


    // =====================================================
    // PREPARE TABLE DATA
    // =====================================================

    prepareData() {

        if (!this.employees.length) {
            return;
        }


        let result = [];


        this.employees.forEach(employee => {

            const employeeTasks = this.tasks.filter(
                task => task.Assigned_To__c === employee.Id
            );


            const totalTasks = employeeTasks.length;


            const completedTasks = employeeTasks.filter(
                task => task.Status__c === 'Completed'
            ).length;


            const pendingTasks = employeeTasks.filter(
                task => task.Status__c !== 'Completed'
            ).length;


            // Employee has tasks
            if (employeeTasks.length > 0) {

                employeeTasks.forEach(task => {

                    result.push({

                        id:
                            employee.Id + '-' + task.Id,

                        employeeId:
                            employee.Id,

                        employeeName:
                            employee.Name,

                        role:
                            employee.Role__c,

                        projectName:
                            employee.Project__r?.Name,

                        teamLead:
                            employee.Team_Lead__r?.Name,

                        taskId:
                            task.Id,

                        taskName:
                            task.Name,

                        taskStatus:
                            task.Status__c,

                        priority:
                            task.Priority__c,

                        dueDate:
                            task.Due_Date__c,

                        description:
                            task.Description__c,

                        totalTasks:
                            totalTasks,

                        completedTasks:
                            completedTasks,

                        pendingTasks:
                            pendingTasks

                    });

                });

            }

            // Employee has no task
            else {

                result.push({

                    id:
                        employee.Id,

                    employeeId:
                        employee.Id,

                    employeeName:
                        employee.Name,

                    role:
                        employee.Role__c,

                    projectName:
                        employee.Project__r?.Name,

                    teamLead:
                        employee.Team_Lead__r?.Name,

                    taskId:
                        null,

                    taskName:
                        'No Task Assigned',

                    taskStatus:
                        'Not Started',

                    priority:
                        null,

                    dueDate:
                        null,

                    description:
                        null,

                    totalTasks:
                        0,

                    completedTasks:
                        0,

                    pendingTasks:
                        0

                });

            }

        });


        this.displayData = result;

    }


    // =====================================================
    // SEARCH EMPLOYEE
    // =====================================================

    handleSearch(event) {

        this.searchKey =
            event.target.value.toLowerCase();


        if (!this.searchKey) {

            this.prepareData();

            return;

        }


        this.displayData =
            this.displayData.filter(row =>
                row.employeeName
                    ?.toLowerCase()
                    .includes(this.searchKey)
            );

    }


    // =====================================================
    // EMPLOYEE CLICK
    // =====================================================

    handleEmployeeClick(event) {

        const employeeId =
            event.currentTarget.dataset.id;


        // Find employee
        this.selectedEmployee =
            this.employees.find(
                employee =>
                    employee.Id === employeeId
            );


        // Find employee tasks
        this.selectedEmployeeTasks =
            this.tasks
                .filter(
                    task =>
                        task.Assigned_To__c === employeeId
                )
                .map(task => ({

                    id:
                        task.Id,

                    name:
                        task.Name,

                    status:
                        task.Status__c,

                    priority:
                        task.Priority__c,

                    dueDate:
                        task.Due_Date__c,

                    description:
                        task.Description__c

                }));


        this.showEmployeeModal = true;

    }


    // =====================================================
    // CLOSE MODAL
    // =====================================================

    closeEmployeeModal() {

        this.showEmployeeModal = false;

        this.selectedEmployee = null;

        this.selectedEmployeeTasks = [];

    }

}