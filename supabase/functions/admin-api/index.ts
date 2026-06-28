// Supabase Edge Function: Admin API
import { serve } from "https://deno.land/std@0.131.0/http/server.ts";

serve(async (req) => {
  return new Response(
    JSON.stringify({ message: "Admin API Edge Function operational" }),
    { headers: { "Content-Type": "application/json" } }
  );
});
