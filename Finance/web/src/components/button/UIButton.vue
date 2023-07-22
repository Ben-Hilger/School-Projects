<template>
    <button type="button" class="btn" v-bind:class="getButtonClass()">
        {{ text }}
    </button>
</template>

<script setup lang="ts">
let props = defineProps({
    text: String,
    type: String
})

function getButtonClass() {
    switch(props.type) {
        case "primary":
            return 'btn-outline-primary'
        case "secondary":
            return 'btn-outline-secondary'
        case "danger":
            return "btn-outline-danger"
        case "success":
            return "btn-outline-success"
        default:
            return "btn-secondary"
    }
}

</script>
