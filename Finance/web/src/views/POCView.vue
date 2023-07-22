<template>
    <UILabel 
        v-bind:description="'Total Net Worth'"
        v-bind:full-width="true"
        v-bind:has-border="true"
        v-bind:label="getFormattedCurrency(calcNetWorth())"
        v-bind:rounded-border="true"
        v-bind:text-size="'ts-lg'"
        class="py-1"
    />
    <div class="flex flex-row">
        <div class="flex-1 px-2 flex-align-items-center flex flex-column">
            <UILabel
            v-bind:description="'Assets'"
            v-bind:full-width="false"
            v-bind:has-border="true"
            v-bind:label="getFormattedCurrency(sumAssets())"
            v-bind:rounded-border="true"
            v-bind:text-size="'ts-lg'"
            />
            <UIButton 
                class="mt-2"
                v-bind:text="'New Asset'"
                v-bind:type="'primary'"
                v-bind:rounded-border="true"
                data-toggle="modal" data-target="#addAssets"
            />
            <UITable class="mt-2 m-2"
            v-bind:headers="headers"
            v-bind:items="assets"
            >
            <template v-slot:body="{props}">
                <td class="text-center">
                     {{ props.name }}
                </td>
                <td class="text-center">
                     {{ getFormattedCurrency(props.amount ?? 0) }}
                </td>
            </template>
        </UITable>

        </div>
        
        <div class="flex-1 flex-align-items-center flex flex-column pr-2">
            <UILabel 
            v-bind:description="'Liabilities'"
            v-bind:full-width="false"
            v-bind:has-border="true"
            v-bind:label="getFormattedCurrency(sumLiabilities())"
            v-bind:rounded-border="true"
            v-bind:text-size="'ts-lg'"
            />
            <UIButton 
                class="mt-2"
                v-bind:text="'New Liability'"
                v-bind:type="'primary'"
                v-bind:rounded-border="true"
                v-bind:has-border="true"   
                data-toggle="modal" data-target="#addLiab"
                />
            <UITable class="mt-2 m-2"
            v-bind:headers="headers"
            v-bind:items="liabilities"
            >
            <template v-slot:body="{props}">
                <td class="text-center">
                     {{ props.name }}
                </td>
                <td class="text-center">
                     {{ getFormattedCurrency(props.amount ?? 0) }}
                </td>
            </template>
            </UITable>
        </div>
    </div>

    <div class="modal fade" id="addLiab" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="flex flex-justify-center flex-align-items-center py-2 w-100">
                        <UIInput class="pr-1 w-50" 
                            v-bind:placeholder="'Name'"
                            v-model="currentName"/>
                        <UIInput class="pr-1 w-50" 
                                v-bind:placeholder="'Amount'"
                                v-bind:type="'number'"
                                v-model="currentAmount"/>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-primary" data-dismiss="modal" v-on:click="addNew(2)">Add</button>
                    <button type="button" class="btn btn-outline-danger" data-dismiss="modal" v-on:click="cancel()">Cancel</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="addAssets" tabindex="-1" role="dialog" aria-labelledby="addAssetsLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="flex flex-justify-center flex-align-items-center py-2 w-100">
                        <UIInput class="pr-1 w-50" 
                            v-bind:placeholder="'Name'"
                            v-model="currentName"/>
                        <UIInput class="pr-1 w-50" 
                                v-bind:placeholder="'Asset Amount'"
                                v-bind:type="'number'"
                                v-model="currentAmount"/>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-primary" data-dismiss="modal" v-on:click="addNew(1)">Add</button>
                    <button type="button" class="btn btn-outline-danger" data-dismiss="modal" v-on:click="cancel()">Cancel</button>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup lang="ts">
import UIButton from '@/components/button/UIButton.vue';
import UILabel from '@/components/labels/UILabel.vue';
import UIInput from '@/components/input/UIInput.vue';
import UITable from '@/components/table/UITable.vue';

import { inject, ref } from 'vue' 
import TableHeader from '@/domain/table/TableHeader';
import type IFormatter from '@/service/formatter/IFormatter';

const headers: TableHeader[] = [
    new TableHeader("Name"),
    new TableHeader("Amount")
]

const formatter: IFormatter|undefined = inject("$formatterService");

let currentName = ref<string>()
let currentAmount = ref<number>()

let assets = ref<{name: string, amount: number}[]>([])
let liabilities = ref<{name: string, amount: number}[]>([])

function reset() {
    currentName.value = undefined
    currentAmount.value = undefined
}

function sumAssets() {
    let sum = 0;
    assets.value.forEach(element => {
        sum += element.amount
    });
    return sum;
}

function sumLiabilities() {
    let sum = 0;
    liabilities.value.forEach(element => {
        sum += element.amount
    })
    return sum;
}

function calcNetWorth() {
    return sumAssets() - sumLiabilities()
}

function addNew(value: number) {
    if (currentAmount.value === undefined || currentName.value === undefined) {
        return;
    }

    if (value === 1) {
        assets.value?.push({name : currentName.value, amount: currentAmount.value})
    } else if (value === 2) {
        liabilities.value?.push({name : currentName.value, amount: currentAmount.value})
    }
    reset();
}

function cancel() {
    reset();
}

function getFormattedCurrency(numberToFormat: number): string {
    if (!formatter) {
        return String(numberToFormat)
    }
    return formatter.formatCurrency(numberToFormat)
}


</script>