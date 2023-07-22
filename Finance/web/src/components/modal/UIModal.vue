<template>
    <div class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" v-bind:id="id">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Modal title</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <slot name="body">
                        <p>Modal body text goes here.</p>
                    </slot>
                </div>
                <div class="modal-footer">
                    <slot name="footer">
                        <button type="button" class="btn btn-primary">Save changes</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </slot>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup lang="ts">

defineProps({
    id: String
})

</script>