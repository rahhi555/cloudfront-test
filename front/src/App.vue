<script setup lang="ts">
import { RouterView } from 'vue-router'
import TheHeader from './components/templates/TheHeader.vue';
import SnackBar from './components/templates/SnackBar.vue';
</script>

<template>
  <TheHeader />
  <SnackBar />
  <main>
    <RouterView />
  </main>
</template>
