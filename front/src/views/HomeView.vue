<script setup lang="ts">
import { RouterLink } from 'vue-router'
</script>

<template>
  <main> 
    <h1>ホーム</h1>   
    <div>
      <RouterLink to="/create">記事作成画面</RouterLink>
    </div>
    <div>
      <RouterLink to="/blogs">記事一覧画面</RouterLink>
    </div>
  </main>
</template>
