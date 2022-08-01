import { defineStore } from "pinia";
import type { User } from "~/types/fetch/models";
import { AuthApi } from "~/types/fetch/apis";
import { DefaultConfig, Configuration } from "~/types/fetch/runtime";

type AuthHeaders = {
  "access-token": string | null;
  client: string | null;
  expiry: string | null;
  "Content-Type": string | null;
  uid: string | null;
};

const getAuthDataFromStorage = (): AuthHeaders => {
  return {
    "access-token": localStorage.getItem("access-token"),
    client: localStorage.getItem("client"),
    expiry: localStorage.getItem("expiry"),
    uid: localStorage.getItem("uid"),
    "Content-Type": "application/json",
  };
};

const setAuthDataFromResponse = (headers: Headers) => {
  const authData: AuthHeaders = {
    uid: headers.get("uid"),
    expiry: headers.get("expiry"),
    client: headers.get("client"),
    "access-token": headers.get("access-token"),
    "Content-Type": "application/json",
  };

  if (authData["access-token"] && authData["client"] && authData["uid"] && authData["expiry"]) {
    localStorage.setItem("access-token", authData["access-token"]);
    localStorage.setItem("client", authData["client"]);
    localStorage.setItem("uid", authData["uid"]);
    localStorage.setItem("expiry", authData["expiry"]);
  }
};

const removeAuthDataFromStorage = (): void => {
  localStorage.removeItem("access-token");
  localStorage.removeItem("client");
  localStorage.removeItem("uid");
  localStorage.removeItem("expiry");
};

const setUserFromResponse = (user: User): void => {
  localStorage.setItem("user", JSON.stringify(user));
}

const getUserFromStorage = (): User | null => {
  const user = localStorage.getItem("user");
  if (user) {
    return JSON.parse(user);
  }
  return null;
}

const removeUserFromStorage = (): void => {
  localStorage.removeItem("user");
}

export const useAuth = defineStore("auth", {
  state: () => {
    return {
      user: undefined as User | undefined,
    };
  },

  getters: {

    isAuthenticated: (state) => {
      return !!state.user;
    },

    isClient: (state) => {
      return !!state.user && state.user.type === "Client";
    },

    isOffice: (state) => {
      return !!state.user && state.user.type === "Office";
    }

  },

  actions: {
    async login({ email, password }: { email: string; password: string }) {
      const authApi = new AuthApi();
      const res = await authApi.signInRaw({ signInRequest: { email, password } });

      const { data } = (await res.value());

      this.user = data;

      setUserFromResponse(data)
      setAuthDataFromResponse(res.raw.headers);

      DefaultConfig.config = new Configuration({
        headers: {
          ...getAuthDataFromStorage(),
        },
      });
    },

    async logout() {
      const authApi = new AuthApi();
      await authApi.signOut();

      this.user = undefined

      removeAuthDataFromStorage();
      removeUserFromStorage();

      DefaultConfig.config = new Configuration({
        headers: {},
      });
    },

    async validateToken() {
      const authDatas = getAuthDataFromStorage();
      const user = getUserFromStorage();

      if (!authDatas["access-token"] || !authDatas["client"] || !authDatas["uid"] || !authDatas["expiry"] || !user) {
        return;
      }

      this.user = user;

      DefaultConfig.config = new Configuration({
        headers: {
          ...getAuthDataFromStorage(),
        },
      });

      const authApi = new AuthApi();
      authApi
        .validateTokenRaw()
        .then(async (res) => {
          setAuthDataFromResponse(res.raw.headers);
        })
        .catch(() => {
          removeAuthDataFromStorage();
          removeUserFromStorage();
          this.user = undefined;
        });
    },
  },
});
