<template>
    <div class="entry-view p-2">
        <UILabel 
            v-bind:description="'Total Net Worth'"
            v-bind:full-width="true"
            v-bind:has-border="true"
            v-bind:label="'$1,000,000'"
            v-bind:rounded-border="true"
            v-bind:text-size="'ts-lg'"
            class="py-1"
        />
        <div class="flex flex-row">
            <div class="flex-1 pr-1">
                <UILabel
                v-bind:description="'Assets'"
                v-bind:full-width="false"
                v-bind:has-border="true"
                v-bind:label="'$1,000,000'"
                v-bind:rounded-border="true"
                v-bind:text-size="'ts-lg'"
                />
                &nbsp;
                <UIButton 
                    v-bind:text="'New Asset'"
                    v-bind:rounded-border="true"
                    v-bind:has-border="true"
                />
            </div>
            
            <div class="flex-1">
                <UILabel 
                v-bind:description="'Liabilities'"
                v-bind:full-width="false"
                v-bind:has-border="true"
                v-bind:label="'$1,000,000'"
                v-bind:rounded-border="true"
                v-bind:text-size="'ts-lg'"
                />
                &nbsp;
                <UIButton 
                    v-bind:text="'New Liability'"
                    v-bind:rounded-border="true"
                    v-bind:has-border="true"
                />
            </div>
        </div>
        
        <div class="">
            <span></span>
        </div>
    </div>
</template>

<script setup lang="ts">
import UIButton from '@/components/button/UIButton.vue';
import UILabel from '@/components/labels/UILabel.vue';
import type IApiService from '@/service/api/IApiService';
import { computed, inject, onBeforeMount, ref } from 'vue';

const apiService: IApiService|undefined = inject("$apiService");

</script> 

<style lang="less">
.entry-view {

    .total-net-worth {
        align-items: center;
        justify-content: center;
        border: 1px solid black;
        border-radius: 4px;
    }
}
</style>