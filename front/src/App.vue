<script setup lang="ts">
import { computed, ref } from 'vue'
import { RouterLink, RouterView } from 'vue-router'

const flg = ref(false)
const color = computed(() => flg.value ? 'red' : 'blue')
</script>

<template>
  <header>
    <div class="wrapper">
      <h1>ブログアプリ</h1>
      <button @click="flg = !flg">フラグ</button>
      <nav>
        <RouterLink to="/">Home</RouterLink>
      </nav>
    </div>
  </header>

  <RouterView />
</template>

<style scoped lang="sass">
.wrapper
  margin: auto
  width: 1000px

  h1
    background-color: v-bind(color)
</style>