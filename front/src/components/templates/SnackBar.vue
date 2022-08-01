<script setup lang="ts">
import { useSnackBar } from "@/composables/useSnackBar"

const { snackBarStatus } = useSnackBar()
</script>

<template>
  <div v-if="snackBarStatus.isVisible" :class="$style.snackbar">
    {{ snackBarStatus.message }}
  </div>
</template>

<style module>
.snackbar {
    position: fixed;
    left: 50%;
    transform: translateX(-50%);
    width: 50%;
    height: 3rem;
    padding-left: 1rem;
    line-height: 3rem;
    border-radius: 5px;
    box-shadow: 1px 1px 1px 1px rgba(0,0,0,0.2);
    background-color: #17a2b8;
    color: white;
}
</style>