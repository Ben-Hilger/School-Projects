<template>
    <div class="flex flex-justify-center flex-align-items-center flex-column">
        <UILabel v-bind:label="'Total Assets'"
                v-bind:text-size="'ts-lg'"/>

        <UIButton class="w-25" 
                v-bind:text="'+ New Asset'" 
                v-bind:type="'primary'" 
                v-on:click="toggleNewAsset"/> 

        <div class="flex flex-justify-center flex-align-items-center pt-5 w-100" 
            v-if="isAdding">
            
            <UIInput class="pr-1 w-25" 
                    v-bind:placeholder="'Asset Name'"
                    v-model="currentSelectedEntryName"/>
            <UIInput class="pr-1 w-25" 
                    v-bind:placeholder="'Asset Amount'"
                    v-bind:type="'number'"
                    v-model="currentAmount"/>
            <UIButton v-bind:text="'Add'" 
                    v-bind:type="'success'"
                    v-on:click="addNewAsset()"/>

        </div>
        <div class="flex flex-row pt-3">
            <UIButton v-bind:text="item.name" 
                v-bind:type="'success'"
                v-on:click="addNewAsset()"
                v-for="item in entryTypes" />
        </div>
        <UITable class="mt-5 m-2 w-75"
            v-bind:headers="headers"
            v-bind:items="entries"
            >
            <template v-slot:body="{props}">
                <td class="text-center">
                    {{ 1 }}
                </td>
                <td class="text-center">
                     {{ getFormattedCurrency(props.amount ?? 0) }}
                </td>
                <td class="text-center">
                     {{ props.entryTypeName }}
                </td>
                <td class="text-center">
                     {{ getFormattedDate(props.dateAddedUtc) }}
                </td>
                <td class="text-center">
                     {{ getFormattedDate(props.dateModifiedUtc) }}
                </td>
            </template>
        </UITable>
    </div>
</template>

<script setup lang="ts">
import UIButton from '@/components/button/UIButton.vue';
import UIInput from '@/components/input/UIInput.vue';
import UILabel from '@/components/labels/UILabel.vue';
import UITable from '@/components/table/UITable.vue';
import Entry from '@/domain/entry/Entry';
import type { EntryType } from '@/domain/entry/Entry';
import TableHeader from '@/domain/table/TableHeader';
import type IApiService from '@/service/api/IApiService';
import type IFormatter from '@/service/formatter/IFormatter';
import { inject, onBeforeMount, ref, watch } from 'vue';

const formatter: IFormatter|undefined = inject("$formatterService");
const apiService: IApiService|undefined = inject("$apiService");

let isAdding = ref(false);
let currentSelectedEntry = ref<number|null>(null)
let currentSelectedEntryName = ref<string|undefined>(undefined)
let currentAmount = ref<number|null>(null)

let entries = ref<Entry[]>([])
let entryTypes = ref<EntryType[]>([])

onBeforeMount(() => {
    getData()
})

watch(currentSelectedEntry, (current) => {
    console.log(current)
})

const headers: TableHeader[] = [
    new TableHeader("#"),
    new TableHeader("Asset Amount"),
    new TableHeader("Asset Type"),
    new TableHeader("Date Added"),
    new TableHeader("Date Modified")
]

function toggleNewAsset() {
    isAdding.value = true;
}

async function addNewAsset() {
    if (!currentSelectedEntry.value || !currentSelectedEntryName.value) {
        return;
    }
    
    let entry = new Entry();
    entry.entryTypeId = currentSelectedEntry.value;
    entry.name = currentSelectedEntryName.value;
    entry.amount = currentAmount.value;

    await postNewEntry(entry);
    getData();
}

async function postNewEntry(newEntry: Entry) {
    if (apiService) {
        try {
            await apiService.post<Entry>("entry", newEntry);
        } catch {}
    }
}

function getFormattedDate(dateString: string): string {
    const date = new Date(dateString);
    if (!date || !formatter) {
        return "No Date Recorded"
    }
    return formatter.formatDateLong(date)
}

function getFormattedCurrency(numberToFormat: number): string {
    if (!formatter) {
        return String(numberToFormat)
    }
    return formatter.formatCurrency(numberToFormat)
}

async function getData() {
    if (apiService) {
        try {
            let entryPromise = apiService.getAll<Entry>("entry");
            let entryTypesPromise = apiService.getAll<EntryType>("entry/types");
            [entries.value, entryTypes.value] = await Promise.all([entryPromise, entryTypesPromise]);
            // currentSelectedEntry.value = entryTypes.value.length > 0 ? entryTypes.value[0].id : undefined;
        } catch {}
    }
}


</script>

<stlye lang="less">

</stlye>