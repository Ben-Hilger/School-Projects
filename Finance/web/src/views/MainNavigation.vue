<script setup lang="ts">
import UILabel from '@/components/labels/UILabel.vue';
import Routes from '@/router/routes';
import { useRouter } from 'vue-router';


const router = useRouter()

const options: {label: string, nameOfRoute: string}[] = [
    {label: "Assets", nameOfRoute: "assets"},
    {label: "Liabilities", nameOfRoute: "liabilities"},
]

const bottomOptions: {label: string, nameOfRoute: string}[] = [
    {label: "Settings", nameOfRoute: Routes.SETTINGS_NAME}
];

function navigateTo(link: string) {
    router.push({name: link})
}


</script>


<template>
    <div class="navigation-view">
        <div class="top-bar-navigation w-100 flex">
            <div class="ts-lg pl-2 py-2">
                Net Worth Calculator
            </div>
        </div>
        <div class="main-content-space flex flex-row">
            <!-- <div class="side-bar-navigation flex flex-column" id="side-bar-navigation">
                <div class="top-options w-100">
                    <UILabel class="nav-item"
                        v-for="option in options"
                        v-bind:label="option.label"
                        v-on:click="navigateTo(option.nameOfRoute)" />
                </div>
                <div class="bottom-options">
                    <UILabel class="nav-item"
                        v-for="option in bottomOptions"
                        v-bind:label="option.label"
                        v-on:click="navigateTo(option.nameOfRoute)" />
                </div>
            </div> -->
            <div class="content-view">
                <RouterView />
            </div>
        </div>
    </div>
</template>

<style lang="less">
.navigation-view {
    
    .top-bar-navigation {
        background-color: rgb(86, 86, 232);
        align-items: center;
        justify-content: space-between;
    }

    .side-bar-navigation {
        flex: 1; 
        border-right: 1px solid darkgray; 
        background-color: rgba(211, 211, 211, 0.537);  
        height: calc(100vh - 64px);
    }

    .content-view {
        flex: 8;
    }

    .nav-item {
        border: 1px solid darkgray;
        border-collapse: collapse;
        cursor: pointer;
    }

    .local-link {
        text-decoration: none;
        color: black;
    }

    .bottom-options {
        margin-top: auto;
    }

}
</style>