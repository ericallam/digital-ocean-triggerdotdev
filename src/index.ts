import { customEvent, Trigger } from "@trigger.dev/sdk";
import { z } from "zod";

export {};

new Trigger({
  id: "testing-digital-ocean-deploy",
  name: "Testing Digital Ocean Deploy",
  on: customEvent({
    name: "digital.ocean",
    schema: z.any(),
  }),
  run: async (event) => {
    return event;
  },
}).listen();
