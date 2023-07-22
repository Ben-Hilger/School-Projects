<template>
    <div class="form-group">
        <select class="form-control" v-on:change="onChange($event)">
            <option v-for="item in items" v-bind:selected="item.id === modelValue" v-bind:data-value="item.id">
                <slot name="option" v-bind:props="item">
                </slot>
            </option>
        </select>
    </div>
</template>

<script setup lang="ts">

const emit = defineEmits(['update:modelValue'])

defineProps({
    items: {
        type: Array<any>
    },
    modelValue: {
        required: true
    }
})

function onChange(event: Event) {
    if (event && event.target) {
        let target = event.target as HTMLInputElement
        emit('update:modelValue', target.getAttribute("data-value"));
    }
}

</script>

<stlye lang="less">

</stlye>