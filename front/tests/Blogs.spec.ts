import { afterAll, beforeAll, afterEach, it, expect } from "vitest";
import Blogs from "../src/views/Blogs.vue";
import { render, waitFor } from "@testing-library/vue";
import router from "../src/router";
import { setupServer } from "msw/node";
import { rest } from "msw";
import { handlers } from "../mock";
import "whatwg-fetch";

const server = setupServer(...handlers);
beforeAll(() => server.listen());
afterAll(() => server.close());
afterEach(() => server.resetHandlers());

it("blogsのタイトルが表示されること", async () => {
  server.use(
    rest.get("http://localhost:3000/blogs", (req, res, ctx) => {
      return res(ctx.json([{ title: "Rubyについて" }, { title: "Pythonについて" }, { title: "Goについて" }]));
    })
  );
  const { getByText } = render(Blogs, { global: { plugins: [router] } });
  await waitFor(() => { 
    getByText("Rubyについて") 
    getByText("Pythonについて") 
    getByText("Goについて") 
    expect(() => getByText("TypeScriptについて")).toThrowError()
  });
});
