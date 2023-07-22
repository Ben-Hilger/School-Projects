<template>
    <div class="input-group">
        <span class="input-group-text" v-bind:id="id" v-if="describer">{{ describer }}</span>
        <input v-bind:placeholder="placeholder" 
                v-bind:type="type" 
                class="form-control" 
                aria-label="Sizing example input" 
                v-bind:aria-describedby="id"
                v-model="localValue">
    </div>
</template>


<script setup lang="ts">
import { watch, ref } from 'vue';

const emit = defineEmits<{
    (event: 'update:modelValue', payload: string): void
}>();

let props = defineProps({
    modelValue: {
        required: true
    },
    describer: {
        type: String,
        default: null
    },
    placeholder: {
        type: String,
        default: null
    },
    type: {
        type: String,
        default: 'text'
    }
})

let localValue = ref("")

const id = `${props.describer}-span`

watch(localValue, (currentValue) => {
    emit('update:modelValue', currentValue)
})

</script>