<script setup lang="ts">
import { RouterLink, useRouter } from "vue-router";
import { reactive } from "vue";
import { AuthApi } from "~/types/fetch";
import { useSnackBar } from "@/composables/useSnackBar"
import type { Props } from "@/views/Completed.vue";

const params = reactive({
  name: "",
  email: "",
  password: "",
  tel: "",
  postCode: "",
  address: "",
});

const { push } = useRouter();

const signUp = () => {
  new AuthApi()
    .signUp({
      signUpRequest: {
        ...params,
        type: "Office",
        confirmSuccessUrl: "http://localhost:8080",
      },
    })
    .then(() => {
      push({
        name: "completed",
        params: {
          title: "利用者・仮登録完了",
          body: "入力いただいたメールアドレスに確認メールを送付いたしました。",
          linkText: "ホームケアナビトップに戻る",
          link: "/home",
        } as Props,
      });
    })
    .catch((res) => {
      const { show } = useSnackBar();
      (res.response as Response).json().then((data) => show(data.errors.full_messages[0]));
    });
};
</script>

<template>
  <div>
    <p>
      <RouterLink to="/login">ログインはこちら</RouterLink>
    </p>
    <p>
      <RouterLink to="/signup">一般の方はこちら</RouterLink>
    </p>
    <div>
      <h1>事務所・新規登録</h1>
      <form>
        <div>
          <label>
            事務所名
            <input type="text" v-model="params.name" />
          </label>
        </div>
        <div>
          <label>
            メールアドレス
            <input type="email" v-model="params.email" />
          </label>
        </div>
        <div>
          <label>
            パスワード
            <input type="password" v-model="params.password" />
          </label>
        </div>
        <div>
          <label>
            電話番号
            <input type="tel" v-model="params.tel" />
          </label>
        </div>
        <div>
          <label>
            郵便番号
            <input type="text" v-model="params.postCode" />
          </label>
        </div>
        <div>
          <label>
            住所
            <input type="text" v-model="params.address" />
          </label>
        </div>
        <div>
          <button type="button" @click="signUp">新規登録</button>
        </div>
      </form>
    </div>
  </div>
</template>
