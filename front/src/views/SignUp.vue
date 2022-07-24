<script setup lang="ts">
import { RouterLink } from "vue-router";
import { ref } from "vue";

const name = ref("")
const email = ref("")
const password = ref("")
const tel = ref("")
const postCode = ref("")
const address = ref("")

const signUp = () => {}
</script>

<template>
  <div>
    <RouterLink to="/login">ログインはこちら</RouterLink>
    <div>
      <h1>新規登録</h1>
      <form>
        <div>
          <label>
            お名前
            <input type="text" v-model="name" />
          </label>
        </div>
        <div>
          <label>
            メールアドレス
            <input type="email" v-model="email" />
          </label>
        </div>
        <div>
          <label>
            パスワード
            <input type="password" v-model="password" />
          </label>
        </div>
        <div>
          <label>
            電話番号
            <input type="tel" v-model="tel" />
          </label>
        </div>
        <div>
          <label>
            郵便番号
            <input type="text" v-model="postCode" />
          </label>
        </div>
        <div>
          <label>
            住所
            <input type="text" v-model="address" />
          </label>
        </div>
        <div>
          <button type="button" @click="signUp">新規登録</button>
        </div>
      </form>
    </div>
  </div>
</template>
