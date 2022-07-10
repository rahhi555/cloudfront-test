import { it } from "vitest";
import { render, fireEvent, waitFor } from "@testing-library/vue";
import router from "../src/router";
import App from "../src/App.vue"

it("hoge", async () => {
  const { getByTestId, findByText, getByText } = render(App, { global: { plugins: [router] } });
  await findByText('ホーム')
  await router.push('/blog/1')
  await findByText('ブログ詳細画面')
  await fireEvent.click(getByTestId('create-link'))
  await waitFor(() =>  getByText('ブログ作成画面'))
});
