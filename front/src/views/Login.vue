<script setup lang="ts">
import { ref } from "vue";

const email = ref("")
const password = ref("")

const login = () => {}
</script>

<template>
  <div>
    <form>
      <label>
        <span>メールアドレス</span>
        <input type="text" v-model="email" />
      </label>
      <label>
        <span>パスワード</span>
        <input type="password" v-model="password" />
      </label>
      <button @click.prevent="login">ログイン</button>
    </form>
  </div>
</template>