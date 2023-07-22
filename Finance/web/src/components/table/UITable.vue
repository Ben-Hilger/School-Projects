<template>
    <table class="table table-striped table-bordered">
        <thead>
            <th v-for="header in headers" class="table-header">
                {{ header.label }}
            </th>
        </thead>
        <tbody>
            <tr v-for="item, index in items">
                <slot name="body" v-bind:props="item">
                </slot>
            </tr>
        </tbody>
    </table>
</template>

<script setup lang="ts">
import type TableHeader from '@/domain/table/TableHeader';

defineProps({
    headers: {
        type: Array<TableHeader>
    },
    items: {
        type: Array<any>
    }
})

</script>

<style lang="less">

.table-header {
    text-align: center;
}

</style>