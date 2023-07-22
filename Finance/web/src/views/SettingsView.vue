<template>
    <div class="settings-view">
        <div class="user-informarion m-2 flex flex-column">
            <div class="flex justify-content-center align-items-center flex-column">
                <UILabel v-bind:label="'User Information'" v-bind:text-size="'ts-md'"/>
                <UIInput class="mb-2" 
                        v-model="localUser.displayName" 
                        v-bind:placeholder="'Display Name'" />
                <UIInput v-model="localUser.email" v-bind:placeholder="'Email'" />
            </div>
            <UILabel v-bind:label="localUser.emailVerified ? 'Email is verified' : 'Email needs to be verified'"/>
            <UIButton v-if="canSave" v-bind:text="'Update'" v-bind:type="'primary'" v-on:click="updateUser()"/>
        </div>
    </div>
</template>

<script setup lang="ts">
import UIInput from '@/components/input/UIInput.vue';
import User from '@/domain/user/User';
import { ref, onBeforeMount, inject, watch, computed } from 'vue'
import _ from 'lodash';
import UILabel from '@/components/labels/UILabel.vue';
import UIButton from '@/components/button/UIButton.vue';
import type IUserService from '@/service/user/IUserService';

const userService: IUserService|undefined = inject('$userService')

let user = ref<User|null>(null);
let localUser = ref<User>(new User());

onBeforeMount(() => {
    getUser()
})

watch(user, (currentVal) => {
    if (currentVal) {
        localUser.value = _.cloneDeep(currentVal);
    }

})

let canSave = computed(() => {
    return !_.isEqual(user.value, localUser.value)
})

function getUser() {
    if (userService) {
        user.value = userService.getUser();
    }
}

function updateUser() {
    if (userService && localUser.value.displayName && localUser.value.displayName.length > 0) {
        let result = userService.updateUser(localUser.value)
        if (result) {
            getUser()
        } else {
            console.log("There was an issue with this")
        }
    }
}

</script>