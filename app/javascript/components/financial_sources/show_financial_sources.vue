 <template>
  <section class="b-tooltips">
    <div 
      class="box" style="margin-top: 60px; margin-left: 300px; margin-right: 300px"
    >
     <h1>Detalle de la fuente</h1>
      <b-tabs type="is-boxed" position="is-centered">
           <div class="center"> <h1>Información de la fuente</h1></div>
          <div class="box" >
 
          <div v-if="financial_source" class="columns is-centered">
            <div class="column is-centered">

              <div class="columns"> 
                <div class="column">
                  <b-field label="Nombre la fuente:">
                       <b-input
                    v-model=" financial_source.name_financial_source " type="text" readonly></b-input>
                  </b-field>
                </div>
              </div>

              <div class="columns">
                <div class="column">
                  <b-field label="Descripción:">
                       <b-input
                    v-model="financial_source.detail" type="text" readonly></b-input>
                  </b-field>
                </div>
              </div>

            </div>
          </div>

          <div v-else>
            <p>Loading</p>
          </div>
          </div>
      </b-tabs>
    </div>
    <a href="/financial_sources"   style= "font-weight: normal;
  font-size: 20px;
  font-family: Arial;
  margin: 10px;
  margin-left: 30px;">Volver</a>
  </section>
</template>


<script>
import axios from "axios";
export default {
  name:"show_financial_sources",
  props: ["id",'queryType', 'modalHeader','financial_sourceId'],
  data() {
    return {
      financial_source: null,
      props: ["id"],
    };
  },
  methods: {
    async getfinancials() {
      const response = await axios.get("/financial_sources/" + this.financial_sourceId + ".json");
      this.financial_source = response.data;
    },

  },
  created() {
    this.getfinancials();
  },
};
</script>

