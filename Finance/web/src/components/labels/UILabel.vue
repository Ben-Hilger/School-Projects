<script setup lang="ts">

defineProps({
  label: String,
  description: {
    type: String,
    default: null
  },
  hasBorder: { 
    type: Boolean,
    default: false
  },
  roundedBorder: { 
    type: Boolean,
    default: false
  },
  textSize: {
    type: String,
    default: 'ts-reg'
  },
  fullWidth: {
    type: Boolean,
    default: false
  }
})

</script>

<template>
    <div class="ui-label w-100" v-bind:class="{'w-100': fullWidth}">
        <div class="flex label p-3" 
            v-bind:class="textSize, {'border': hasBorder, 'border-rounded': roundedBorder, 
                'flex-justify-space-between': description, 'flex-justify-center': !description}">
            <span v-if="description">
                {{ description }}
            </span>
            <span>
                {{ label }}
            </span>
        </div>
    </div>
</template>

<style lang="less">
.ui-label {

    .label {
        align-items: center;
    }

    .border {
        border: 1px solid black;
    }

    .border-rounded {
        border-radius: 4px;
    }
}

</style>