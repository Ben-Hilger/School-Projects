<template>
    <div class="flex flex-colum login-view">
        <div class=" flex pt-5 flex-column flex-align-items-center w-50">
            <div class="ts-lg mb-2">Login to Net Worth Tool</div>
            <UIInput v-model="email"
                v-bind:placeholder="'Email'" 
                class="w-50 mb-2" />
            <UIInput v-bind:value="password" 
                v-bind:placeholder="'Password'" 
                v-model="password"
                class="w-50" />
            <UIButton v-bind:type="'primary'" 
                v-bind:text="'Login'" 
                v-on:click="loginUser()"
                class="mt-2 w-50"/>
            <UIButton v-bind:type="'secondary'" 
                v-bind:text="'Create Account'" 
                class="my-2 w-50"/>
            <UIButton v-bind:type="'danger'" 
                v-bind:text="'Forgot Password?'" 
                class="w-50"/>
        </div>
    </div>
</template>

<script setup lang="ts">
import UIButton from '@/components/button/UIButton.vue';
import UIInput from '@/components/input/UIInput.vue';
import { ref, inject } from 'vue';
import type IAuthService from '@/service/auth/IAuthService';
import { useRouter } from 'vue-router';
import type IApiService from '@/service/api/IApiService';

const authService: IAuthService|undefined = inject("$authService");
const apiService: IApiService|undefined = inject("$apiService");

const router = useRouter()

let email = ref<string>();
let password = ref<string>();

async function loginUser() {
    if (email.value && email.value.length > 0 && email.value.includes("@") &&
        password.value && password.value.length > 0) {
        try {
            let idToken = await authService?.signInUser(email.value, password.value)
            let reponse = await apiService?.post<{idToken: string|undefined|null}>("session", { idToken: idToken })
            if (reponse) {
                router.push({name: 'home'})
            }
        } catch {}
    }
}


</script>

<stlye lang="less">
.login-view {
    justify-content: center;
    align-items: center;
}
</stlye>