<template>
  <section class="b-tooltips">
    <div class="box" style="margin-top: 60px; margin-left: 300px; margin-right: 300px">

      <h1>Detalle del Edificio</h1>
      <b-tabs type="is-boxed" position="is-centered">

        <b-tab-item label="Detalle del Edificio">
          <div class="center">
            <h1>Información del Edificio</h1>
          </div>
          <div class="box" style="margin-top: 60px; margin-left: 100px; margin-right: 100px;">

            <div v-if="building" class="columns is-centered">


              <div class="column is-centered">

                <div class="columns">
                  <div class="column">
                    <b-field label="Nombre edificio:">
                      <b-input v-model="building.name_building " type="text" readonly></b-input>
                    </b-field>
                  </div>
                </div>
                <div class="columns">
                  <div class="column">
                    <b-field label="Numero identificación del edificio:">
                      <b-input v-model="building.identification_number_building" type="text" readonly></b-input>
                    </b-field>
                  </div>
                </div>
                <div class="columns">
                  <div class="column">
                    <b-field label="Monto bruto total invertido en bienes: ">
                      <b-input v-model="total" type="text" readonly></b-input>
                    </b-field>
                  </div>
                </div>

                <div class="columns">
                  <div class="column">
                    <b-field label="Ubicación:">
                      <b-input v-model="building.location_building" type="text" readonly></b-input>
                    </b-field>
                  </div>
                </div>


                <div class="columns">
                  <div class="column">
                    <b-field label="Unidad: ">
                      <b-input icon="eye" icon-clickable @icon-click="Clickshowunit(building.unit_id)"
                        v-model="building.unit.name_unit" type="text" readonly></b-input>
                    </b-field>
                  </div>
                </div>
                <div class="columns">


                  <div class="column" v-show='!(building.duty_manager.active_duty_manager == 0)'>
                    <b-field label="Persona encargada: ">
                      <b-input icon="eye" icon-clickable @icon-click="Clickshowdutymanager(building.duty_manager_id)"
                        v-model="building.duty_manager.name_duty_manager" type="text" readonly></b-input>
                    </b-field>
                  </div>

                  <div class="column" v-show='(building.duty_manager.active_duty_manager == 0)'>
                    <b-field label="Anterior persona asociada:: ">
                      <b-input icon="eye" icon-clickable @icon-click="Clickshowdutymanager(building.duty_manager_id)"
                        v-model="building.duty_manager.name_duty_manager" type="text" readonly></b-input>
                    </b-field>
                  </div>



                </div>



              </div>

            </div>

            <div v-else>
              <p>Loading</p>
            </div>

          </div>
        </b-tab-item>








        <b-tab-item label="Dependencias del edificio">
          <div class="center">
            <h1>Dependencias del edificio</h1>
          </div>


          <div class="column">
            <b-table :data="offices" :paginated="true" per-page="8" striped hoverable :pagination-simple="false"
              pagination-position="bottom" sort-icon="arrow-up" sort-icon-size="is-small"
              aria-next-label="Siguiente" aria-previous-label="Anterior"
              aria-page-label="Página" aria-current-label="Página actual">
              <b-table-column :visible="false" field="id" label="ID" sortable searchable>
                <template v-slot="props">
                  {{ props.row.id }}
                </template>
              </b-table-column>

              <b-table-column field="name_office" label="Nombre dependencia" sortable searchable>
                <template v-slot="props">
                  <a href="#" @click="Clickshowoffice(props.row.id)">{{ props.row.name_office }}</a>

                </template>
              </b-table-column>

              <b-table-column field="identification_number_office" label="N° Identificación" sortable searchable>
                <template v-slot="props">
                  {{ props.row.identification_number_office }}
                </template>
              </b-table-column>

              <b-table-column field="building.name_building" label="Edificio" sortable searchable>
                <template v-slot="props">
                  <a href="#" @click="Clickshowbuilding(props.row.building_id)">{{ props.row.building.name_building
                  }}</a>

                </template>
              </b-table-column>

              <b-table-column field="location" label="Ubicación" sortable searchable>
                <template v-slot="props">
                  {{ props.row.location }}
                </template>
              </b-table-column>

              <b-table-column field="id" width="10" v-slot="props">
                <b-tooltip label="Ver detalle" type="is-info">
                  <b-icon pack="fas" icon="eye" size="is-medium" @click.native="Clickshowoffice(props.row.id)" />
                </b-tooltip>
              </b-table-column>
            </b-table>
          </div>

        </b-tab-item>

        <b-tab-item label="Bienes de la unidad">
          <div class="center">
            <h1>Bienes de la unidad</h1>
          </div>
          <div class="box">
            <div class="column">
              <b-table :data="goods" :paginated="true" per-page="8" striped hoverable :pagination-simple="false"
                pagination-position="bottom"  sort-icon="arrow-up" sort-icon-size="is-small"
                aria-next-label="Siguiente" aria-previous-label="Anterior"
                aria-page-label="Página" aria-current-label="Página actual">

                <b-table-column :visible="false" field="id" label="ID" sortable searchable>
                  <template v-slot="props">
                    {{ props.row.id }}
                  </template>
                </b-table-column>

                <b-table-column field="namegood" label="Nombre" sortable searchable>
                  <template v-slot="props">
                    <a href="#" @click="Clickshowgood(props.row.id)">{{ props.row.namegood }}</a>
                  </template>
                </b-table-column>

                <b-table-column field="identification_number_good" label="N° Inventario" sortable searchable>
                  <template v-slot="props">
                    {{ props.row.identification_number_good }}
                  </template>
                </b-table-column>

                <b-table-column field="duty_manager.name_duty_manager" label="Nombre Persona asociada" sortable
                  searchable>
                  <template v-slot="props">
                    <a href="#" @click="Clickshowdutymanager(props.row.duty_manager_id)">{{
                    props.row.duty_manager.name_duty_manager }}</a>
                  </template>
                </b-table-column>

                <b-table-column field="office.name_building" label="Edificio" sortable searchable>
                  <template v-slot="props">
                    <a href="#" @click="Clickshowbuilding(props.row.office.building_id)">{{
                    props.row.office.name_building }}</a>
                  </template>
                </b-table-column>

                <b-table-column field="office.name_office" label="Dependencia" sortable searchable>
                  <template v-slot="props">
                    <a href="#" @click="Clickshowoffice(props.row.office_id)">{{ props.row.office.name_office }}</a>

                  </template>
                </b-table-column>

                <b-table-column field="id" width="10" v-slot="props" size="is-small">
                  <div class="columns">
                    <div class="column">
                      <b-tooltip label="Ver detalle" type="is-info">
                        <b-icon pack="fas" icon="eye" size="is-medium" @click.native="Clickshowgood(props.row.id)" />
                      </b-tooltip>
                    </div>
                    <div class="column">
                    <b-tooltip label="Anular" type="is-info">
                      <b-icon pack="fas" icon="trash" size="is-medium" @click.native="confirmGoodNull(props.row.id)" />
                    </b-tooltip>
                  </div>

                  </div>
                </b-table-column>

              </b-table>
            </div>
          </div>
        </b-tab-item>

      </b-tabs>
    </div>

    <a href="/buildings" style="font-weight: normal;
  font-size: 20px;
  font-family: Arial;
  margin: 10px;
  margin-left: 30px;">Volver</a>
  </section>
</template>

 
<script>
import axios from "axios";
export default {
  name:"show_building",
  props: ["id",'queryType', 'modalHeader','buildingId'],
  data() {
    return {
      offices: [],
      id_goods_list: [],
      id_offices_list: [],
      goods: [],
      goodamounts: [],
      building: null,
      total: null,
      null_activegood: 0,
      props: ["id"],
    };
  },
  methods: {
    async getoffices() {
      const response = await axios.get(
        "/offices/showofficebuilding/" + this.buildingId + ".json"
      );
      this.offices = response.data;
      this.id_offices_list = this.offices.map(o => o['id']);
      console.log(this.id_offices_list);
    },

    async getbuildings() {
      const response = await axios.get(
        "/buildings/" + this.buildingId + ".json"
      );
      this.building = response.data;
    },

        async getgoodbybuilding() {
      const response = await axios.get("/goods/showgoodbuilding/" + this.buildingId + ".json");
      this.goods = response.data;
      this.goodamounts = this.goods.map(o => o['amount']);
      this.id_goods_list = this.goods.map(o => o['id']);

      const c = 0;
      this.total = this.goodamounts.reduce((a, b) => a + b,c);
      console.log(this.id_goods_list);
    },

    async Clickshowgood(item) {
      window.location.href = "/goods/" + item;
    },

    confirmGoodNull(item) {
      this.$buefy.dialog.confirm({
        title: "Anular Bien",
        message: "¿Esta seguro de querer anular el bien?.",
        confirmText: "Anular",
        cancelText: "Cancelar",
        type: "is-danger",
        hasIcon: true,
        onConfirm: () => this.AnulGoodClick(item),
      });
    },

    async AnulGoodClick(item) {
      const response = await axios.put("/goods/" + item + ".json", {
        activegood: this.null_activegood,
      });
      window.location.href = "/buildings/" + this.buildingId;
    },

    async Clickshowunit(item) {
      const response = (window.location.href = "/units/" + item);
    },

    async Clickshowdutymanager(item) {
      const response = (window.location.href = "/duty_managers/" + item);
    },
    async Clickshowbuilding(item) {
      const response = (window.location.href = "/buildings/" + item);
    },
    async Clickshowoffice(item) {
      const response = (window.location.href = "/offices/" + item);
    },

  },
  created() {
    this.getbuildings();
    this.getoffices();
    this.getgoodbybuilding();
  },
};
</script>




