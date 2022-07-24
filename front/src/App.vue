<script setup lang="ts">
import { RouterView } from 'vue-router'
import HeaderVue from './components/templates/Header.vue';
</script>

<template>
  <HeaderVue />

  <main>
    <RouterView />
  </main>
</template>
